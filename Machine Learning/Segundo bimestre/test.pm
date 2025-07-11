sub normalize_dataset{
    my ($self, $dataset, $minmax) = @_;
        
    #Extract min and max vectors
    my $min = $minmax->slice_axis(axis=>1, begin=>0, end=>1)->T;
    my $max = $minmax->slice_axis(axis=>1, begin=>1, end=>2)->T;

    $dataset->slice([0, $dataset->shape->[0] -1], [0, $dataset->shape->[1] -1]) .=
                ($dataset - $min) / ($max - $min);
}


sub column_means{
    my ($self, $dataset) = @_;
    return mx->nd->mean($dataset, axis=>0);
};


sub column_stdevs{
    my ($self, $dataset, $means) = @_;
    return mx->nd->sqrt(($dataset - $means)->power(2)->sum(axis=>0) / ($dataset->len -1));
}


sub standardize_dataset{
    my ($self, $dataset, $means, $stdevs) = @_;
    $dataset->slice([0, $dataset->shape->[0] -1], [0, $dataset->shape->[1] -1]) .=
    ($dataset - $means) / $stdevs;
} 


#Capitulo 3

sub train_test_split{
    my ($self, $dataset, %args) = (splice (@_, 0, 2), split =>0.6, @_);

    my $train_size = int($args{split} * $dataset->len);
    my $idx        = mx->nd->arange(stop => $dataset->len)->shuffle;
    my $train_idx  = $idx->slice(begin=>0, end=>$train_size);
    my $test_idx   = $idx->slice(begin=> $train_size, end=>$dataset->len);
    my $train      = mx->nd->take($dataset, $train_idx);
    my $test       = mx->nd->take($dataset, $test_idx);
    
    return $train, $test;
}


sub cross_validation_split{
    my ($self, $dataset, %args) = (splice (@_, 0, 2), n_folds=>10, @_);

    my @dataset_split;
    my $fold_size   = int($dataset->len / $args{n_folds});
    my $idx         = mx->nd->arange(stop=>$dataset->len)->shuffle;
    for my $i (0 .. $args{n_folds} -1){
        my $fold_idx = $idx->slice(begin=>$i * $fold_size, end=>($i +1) * $fold_size);
        push @dataset_split, mx->nd->take($dataset, $fold_idx);
    }

    return mx->nd->stack(@dataset_split, axis=>0);
}


sub count_labels{
    my ($self, $dataset) = @_;
    my $Y = $dataset->slice_axis(axis=>1, begin=>-1, end=>$dataset->shape->[-1])
                        ->squeeze(axis=>1);
    my $num_classes = $Y->max->asscalar + 1;
    return mx->nd->one_hot($Y, $num_classes)->sum(axis=>0);
}


#Capitulo 4

sub accuracy_metric{
    my ($self, $actual, $predicted) = @_;
    my $cmp = $predicted->astype($actual->dtype) == $actual;
    return sprintf '%0.2f',
                        (100 * $cmp->astype($actual->dtype)->sum / $actual->len)->asscalar;
}

sub confusion_matrix{
    my ($self, $actual, $predicted) = @_;
    
    #Step 1: One-hot encode the actual and predicted arrays
    my $num_classes       = $actual->max->asscalar + 1;
    my $actual_one_hot    = mx->nd->one_hot($actual, $num_classes);
    my $predicted_one_hot = mx->nd->one_hot($predicted, $num_classes);
                                            
    # Step 2: Compute confusion matrix
    # Matrix multiplication: (actual_one_hot^T) * predicted_one_hot
    return mx->nd->arange(stop=>$num_classes),
            mx->nd->dot($actual_one_hot->T, $predicted_one_hot); 
}


sub print_confusion_matrix{
    my ($self, $unique, $matrix) = @_;
    printf "A/P%s", $unique->aspdl;
    printf "%s", mx->nd->concat($unique->expand_dims(axis=>1), $matrix, dim=>1)->aspdl;
}


sub mae_metric{
    my ($self, $actual, $predicted) = @_;
    return sprintf '%0.2f',
                    (mx->nd->abs($actual - $predicted)->sum / $actual->len)->asscalar;       
}


sub rmse_metric{
    my($self, $actual, $predicted) = @_;
    my $mean_error = ($actual - $predicted)->square()->sum / $actual->len;
    return sprintf '%0.3f', $mean_error->sqrt()->asscalar;
}


sub perf_metrics{
    my ($self, $actual, $predicted_prob, $threshold) = @_;
        
    my ($tp, $fp, $tn, $fn, $tpr, $fpr) = (0, 0, 0, 0);
        
    #Step 1: Threshold to create binary predictions
    my $predicted = $predicted_prob >= $threshold;

    #Step 2: Convert actua and predicted to one-hot encoded matrices
    my $num_classes         = $actual->max->asscalar + 1;
    my $actual_one_hot      = mx->nd->one_hot($actual, $num_classes); #Shape [n, $num_cl]
    my $predicted_one_hot   = mx->nd->one_hot($predicted, $num_classes); #Shape [n, $num_cl]
    
    #Step 3: Compute confusion matrix using dot product
    my $confusion_matrix    = mx->nd->dot($actual_one_hot->T, $predicted_one_hot);
    
    #Extract counts from the confusion matrix
    $tp = $confusion_matrix->at(1)->at(1); # True Positives
    $fn = $confusion_matrix->at(1)->at(0); # False Negatives
    $fp = $confusion_matrix->at(0)->at(1); # False Positives
    $tn = $confusion_matrix->at(0)->at(0); # True Negatives

    #Step 4: Compute TPR and FPR
    $tpr = $tp / ($tp + $fn); # True Positive Rate
    $fpr = $fp / ($fp + $tn); # False Positive Rate

    return sprintf('%0.2f', $fpr->asscalar), sprintf('%0.2f', $tpr->asscalar);
}


# Capitulo 5

sub random_algorithm{
    my ($self, $train, $test) = @_;
    my $output_values =
        $train->slice_axis(axis=>1, begin=>1, end=>$train->shape->[-1])->squeeze();
    return $output_values->shuffle->slice(begin=>0, end=>$test->len);
}


sub zero_rule_algorith_classification{
    my ($self, $train, $test) = @_;
    my $output_values = $train->slice_axis(axis=>1, begin=>1, end=>$train->shape->[-1])->squeeze();
    my $num_classes   = $output_values->max->asscalar + 1;
    my $counter       = mx->nd->one_hot($output_values, $num_classes)->sum(axis=>0);
    my $prediction    = mx->nd->argmax($counter);
    return mx->nd->full([$test->len], $prediction->asscalar);
}
