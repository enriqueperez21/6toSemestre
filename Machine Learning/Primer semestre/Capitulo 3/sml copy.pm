use strict;
use warnings;

use AI::MXNet qw(nd);
use List::Util qw(shuffle);
use Data::Dump qw(dump);
use sml;


# Defined in Section 3.2.1 Train and Test Split
# Function To Split a Dataset.
# Split a dataset into a train and test set
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

# Example of Splitting a Contrived Dataset into Train and Test

# test train/test split
srand(1);
my $dataset        = [[1], [2], [3], [4], [5], [6], [7], [8], [9], [10]];
my ($train, $test) = sml->train_test_split($dataset);
printf "%s\n", dump($train);
printf "%s\n", dump($test);

# Example Output from Splitting a Dataset.
# [[6], [2], [8], [9], [10], [4]]
# [[3], [7], [5], [1]]

# Defined in Section 3.2.2 k-fold Cross-Validation Split
# Function Create A Cross-Validation Split.
# Split a dataset into $k$ folds
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

# Example of a Cross-Validation Split of a Contrived Dataset.
# test cross validation split
srand(1);
my $dataset = [[1], [2], [3], [4], [5], [6], [7], [8], [9], [10]];
my $folds   = sml->cross_validation_split($dataset, n_folds=>5);
printf "%s\n", dump($folds);
# Example Output from Creating a Cross-Validation Split.
# [[[6], [2]], [[8], [9]], [[10], [4]], [[3], [7]], [[5], [1]]]

my ($dataset, $header) = sml->load_csv('./data/iris.csv');
printf "rows: %d\n", scalar @$dataset;
printf "cols: %d\n", scalar @{$dataset->[0]};
print dump @$dataset[0 .. 4];
# rows: 150
# cols: 5
# (
#   [5.1, 3.5, 1.4, 0.2, "Iris-setosa"],
#   [4.9, "3.0", 1.4, 0.2, "Iris-setosa"],
#   [4.7, 3.2, 1.3, 0.2, "Iris-setosa"],
#   [4.6, 3.1, 1.5, 0.2, "Iris-setosa"],
#   ["5.0", 3.6, 1.4, 0.2, "Iris-setosa"],
# )

my $lookup     = sml->str_column_to_int($dataset, -1);
my $rev_lookup = { reverse %$lookup };
printf "lookup:\n%s\n", dump $lookup;
printf "rev_lookup:\n%s\n", dump $rev_lookup;
printf "Modified dataset:\n%s", dump @$dataset[0 .. 4];

# lookup:
# { "Iris-setosa" => 0, "Iris-versicolor" => 1, "Iris-virginica" => 2 }
# rev_lookup:
# { "0" => "Iris-setosa", "1" => "Iris-versicolor", "2" => "Iris-virginica" }
# Modified dataset:
# (
#   [5.1, 3.5, 1.4, 0.2, 0],
#   [4.9, "3.0", 1.4, 0.2, 0],
#   [4.7, 3.2, 1.3, 0.2, 0],
#   [4.6, 3.1, 1.5, 0.2, 0],
#   ["5.0", 3.6, 1.4, 0.2, 0],
# )

sub count_labels{
    my ($self, $dataset) = @_;
    my %counts = ();
    map {$counts{"$_->[-1]"}++} @$dataset;
    return \%counts;
}

sml->add_to_class('count_labels', \&{'count_labels'});

my $counts = sml->count_labels($dataset);
print dump $counts;

# { "Iris-setosa" => 50, "Iris-versicolor" => 50, "Iris-virginica" => 50 }

for my $key (keys %$counts){
    printf "%s => %d ", $rev_lookup->{$key}, $counts->{$key};
}

# Iris-virginica => 50 Iris-versicolor => 50 Iris-setosa => 50 

srand(1);
my ($train, $test) = sml->train_test_split($dataset, split=>0.8);
printf "train size:%d, test size:%d", scalar(@$train), scalar(@$test);
# train size:120, test size:30

print dump (sml->count_labels($train));
# { "0" => 40, "1" => 42, "2" => 38 }

print dump (sml->count_labels($test));
# { "0" => 10, "1" => 8, "2" => 12 }

print dump @$train[0 .. 9];
# (
#   [7.2, 3.2, "6.0", 1.8, 2],
#   [5.9, "3.0", 4.2, 1.5, 1],
#   [6.5, "3.0", 5.5, 1.8, 2],
#   [5.5, 2.4, 3.7, "1.0", 1],
#   [5.8, 2.6, "4.0", 1.2, 1],
#   [4.8, 3.4, 1.6, 0.2, 0],
#   [4.8, 3.4, 1.9, 0.2, 0],
#   [6.1, 2.9, 4.7, 1.4, 1],
#   [6.4, 3.2, 5.3, 2.3, 2],
#   ["5.0", 3.2, 1.2, 0.2, 0],
# )

print dump @$test[0 .. 9];
# (
#   [6.7, 2.5, 5.8, 1.8, 2],
#   [4.6, 3.2, 1.4, 0.2, 0],
#   [6.1, 2.8, 4.7, 1.2, 1],
#   [6.5, 3.2, 5.1, "2.0", 2],
#   [4.4, 3.2, 1.3, 0.2, 0],
#   [7.7, 3.8, 6.7, 2.2, 2],
#   [6.3, 2.5, 4.9, 1.5, 1],
#   [6.7, 3.3, 5.7, 2.5, 2],
#   [6.8, 3.2, 5.9, 2.3, 2],
#   [5.5, 2.4, 3.8, 1.1, 1],
# )

srand(1);
my $folds = sml->cross_validation_split($dataset, n_folds=>10);
printf "%s\n", dump (@$folds[0 .. 1]);
# (
#   [
#     [7.2, 3.2, "6.0", 1.8, 2],
#     [5.9, "3.0", 4.2, 1.5, 1],
#     [6.5, "3.0", 5.5, 1.8, 2],
#     [5.5, 2.4, 3.7, "1.0", 1],
#     [5.8, 2.6, "4.0", 1.2, 1],
#     [4.8, 3.4, 1.6, 0.2, 0],
#     [4.8, 3.4, 1.9, 0.2, 0],
#     [6.1, 2.9, 4.7, 1.4, 1],
#     [6.4, 3.2, 5.3, 2.3, 2],
#     ["5.0", 3.2, 1.2, 0.2, 0],
#     [7.1, "3.0", 5.9, 2.1, 2],
#     [6.9, 3.1, 4.9, 1.5, 1],
#     [6.1, "3.0", 4.9, 1.8, 2],
#     [5.2, 2.7, 3.9, 1.4, 1],
#     [6.3, 2.9, 5.6, 1.8, 2],
#   ],
#   ...

printf "ros per fold:%d\n", scalar @{$folds->[0]};
# rows per fold:15

for my $medicion (map {sml->count_labels($_)} @$folds){
    printf "%s\n", dump $medicion;
}

# { "0" => 3, "1" => 6, "2" => 6 }
# { "0" => 5, "1" => 3, "2" => 7 }
# { "0" => 5, "1" => 4, "2" => 6 }
# { "0" => 5, "1" => 4, "2" => 6 }
# { "0" => 6, "1" => 8, "2" => 1 }
# { "0" => 5, "1" => 8, "2" => 2 }
# { "0" => 6, "1" => 4, "2" => 5 }
# { "0" => 5, "1" => 5, "2" => 5 }
# { "0" => 4, "1" => 4, "2" => 7 }
# { "0" => 6, "1" => 4, "2" => 5 }