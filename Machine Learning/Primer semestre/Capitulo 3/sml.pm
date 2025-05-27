use strict;
use warnings;
use Data::Dump qw(dump);
use List::Util qw(shuffle);
use sml;

sub train_test_split{
    my($self, $dataset, %args) = (splice (@_, 0, 2), split=>0.6, @_);
    
    my $train_size = int($args{split} * @$dataset);
    my @idx        = shuffle (0 .. $#$dataset);
    my @train_idx  = @idx[0 .. $train_size -1];
    my @test_idx   = @idx[$train_size .. $#$dataset];
    my @train      = @$dataset[@train_idx];
    my @test       = @$dataset[@test_idx];

    return \@train, \@test;
}

sml->add_to_class('train_test_split', \&{'train_test_split'});

sub cross_validation_split{
    my ($self, $dataset, %args) = (splice (@_, 0, 2), n_folds=>10, @_);
    
    my @dataset_split;
    my $fold_size       = int(@$dataset / $args{n_folds});
    my @idx             = shuffle (0 .. $#$dataset);
    for my $i (0 .. $args{n_folds} -1){
        my @fold_idx = @idx[$i * $fold_size .. ($i +1) * $fold_size -1];
        push @dataset_split, [@$dataset[@fold_idx]];
    }

    return \@dataset_split;
}

sml->add_to_class('cross_validation_split', \&{'cross_validation_split'});

sub count_labels{
    my ($self, $dataset) = @_;
    my %counts = ();
    map {$counts{"$_->[-1]"}++} @$dataset;
    return \%counts;
}

sml->add_to_class('count_labels', \&{'count_labels'});

my $accuracy_metric = sub{
    my ($self, $actual, $predicted) = @_;
    my $correct = 0;
    for my $pair (zip @$actual, @$predicted){
        $correct++ if ($pair->[0] == $pair->[1]);
    }
    return sprintf '%0.1f', $correct / @$actual * 100.0;
};

sml->add_to_class('sml', 'accuracy_metric', $accuracy_metric);

# Example of Calculating and Displaying a Pretty Confusion Matrix
my $confusion_matrix = sub{
    my ($self, $actual, $predicted) = @_;

    my @unique = uniq @$actual;
    my $matrix = [map {[]} 0 .. $#unique];
    for my $i (0 .. $#unique){
        $matrix->[$i] = [0, map {$_} 0 .. $#unique -1];
    }
    my (%lookup, $x, $y);
    while (my ($i, $value) = each @unique) {
        $lookup{$value} = $i;
    }

    for my $i (0 .. $#$actual){
        $x = $lookup{$actual->[$i]};
        $y = $lookup{$predicted->[$i]};
        $matrix->[$x]->[$y] += 1;
    }

    return \@unique, $matrix;
};

sml->add_to_class('sml', 'confusion_matrix', $confusion_matrix);
# Function To Calculate a Confusion Matrix.
# calculate a confusion matrix


# Function To Pretty Print a Confusion Matrix.
# pretty print a confusion matrix
my $print_confusion_matrix = sub{
    my ($self, $unique, $matrix) = @_;
    print 'A/P ', join(' ', map {$_} @$unique), "\n";
    while (my ($i, $x) = each @$unique){
        print sprintf " %s| %s\n", $x, join(' ', map {$_} @{$matrix->[$i]});
    }
};

sml->add_to_class('sml', 'print_confusion_matrix', $print_confusion_matrix)

# Function To Calculate Mean Absolute Error.
# Calculate mean absolute error
my $mae_metric = sub{
    my ($self, $actual, $predicted) = @_;
    my $sum_error = 0.0;
    for my $pair (zip $actual, $predicted){
        $sum_error += abs($pair->[0] - $pair->[1]);
    }
    return sprintf '%.3f', $sum_error / @$actual;
};

sml->add_to_class('sml', 'mae_metric', $mae_metric);

# Defined in Section 4.2.4 Root Mean Squared Error
# Function To Calculate Root Mean Squared Error.
# Calculate root mean squared error
my $rmse_metric = sub {
    my ($self, $actual, $predicted) = @_;
    my $sum_error = 0.0;
    for my $pair (zip @$actual, @$predicted) {
        $sum_error += (($pair->[0] - $pair->[1]) ** 2);
    }
    my $mean_error = $sum_error / @$actual;
    return sprintf '%.4f', sqrt($mean_error);
};

sml->add_to_class('sml', 'rmse_metric', $rmse_metric);


# Function to calculate the ROC metrics
my $perf_metrics = sub {
    my ($self, $actual, $y_hat, $threshold) = @_;
    my ($tp, $fp, $tn, $fn, $tpr, $fpr) = (0, 0, 0, 0, 0, 0);
    for my $i (0 .. $#$y_hat) {
        if ($y_hat->[$i] <= $threshold) {
            if ($actual->[$i] == 1) {
                $tp++;
            } else {
                $fp++;
            }
        } else {
            if ($actual->[$i] == 0) {
                $tn++;
            } else {
                $fn++;
            }
        }
    }
    $tpr = $tp / ($tp + $fn);  # True Positive Rate
    $fpr = $fp / ($fp + $tn);  # False Positive Rate

    return $fpr, $tpr;
};

sml->add_to_class('sml', 'perf_metrics', $perf_metrics);

# Function to calculate the integral using the trapezoid rule
my $trapz = sub {
    my ($self, $x, $y) = @_;

    my $sum = 0;
    for my $i (0 .. @$x - 2) {
        $sum += ($x->[$i + 1] - $x->[$i]) * ($y->[$i] + $y->[$i + 1]) / 2;
    }
    return $sum;
};

sml->add_to_class('sml', 'trapz', $trapz);