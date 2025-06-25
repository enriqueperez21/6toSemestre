import mxnet as mx
from mxnet import nd

class SML:
    def __init__(self):
        pass

    @staticmethod
    def add_to_class(cls, method_name, method_func):
        setattr(cls, method_name, method_func)

    @staticmethod
    def dataset_minmax(dataset):
        """
        Devuelve una matriz 2D donde la primera columna es el mínimo por columna
        y la segunda columna es el máximo por columna del dataset dado.
        """
        return nd.stack(nd.min(dataset, axis=0), nd.max(dataset, axis=0), axis=1)
    
    @staticmethod
    def normalize_dataset(dataset, minmax):
        """
        Normaliza in-place cada columna del dataset al rango [0, 1].
        `minmax` se espera con forma (n_features, 2).
        """
        min_vals = nd.slice_axis(minmax, axis=1, begin=0, end=1).reshape((-1,))
        max_vals = nd.slice_axis(minmax, axis=1, begin=1, end=2).reshape((-1,))
        dataset[:] = (dataset - min_vals) / (max_vals - min_vals)

    @staticmethod
    def column_means(dataset):
        """Media columna a columna."""
        return nd.mean(dataset, axis=0)

    @staticmethod
    def column_stdevs(dataset, means):
        """Desviación estándar de cada columna (grados de libertad = n-1)."""
        n = dataset.shape[0]
        return nd.sqrt(((dataset - means) ** 2).sum(axis=0) / (n - 1))

    @staticmethod
    def standardize_dataset(dataset, means, stdevs):
        """Estandariza in-place (z-score)."""
        dataset[:] = (dataset - means) / stdevs

    @staticmethod
    def train_test_split(dataset, split=0.6):
        """
        Baraja filas y separa en train/test según `split` (porcentaje para train).
        """
        n = dataset.shape[0]
        train_size = int(split * n)
        idx = nd.random.shuffle(nd.arange(n))
        train_idx, test_idx = idx[:train_size], idx[train_size:]
        train = nd.take(dataset, train_idx)
        test = nd.take(dataset, test_idx)
        return train, test
    
    @staticmethod
    def cross_validation_split(dataset, n_folds=10):
        """
        Devuelve un NDArray con forma (n_folds, fold_size, n_features).
        Cada slice [i] es un fold.
        """
        n = dataset.shape[0]
        fold_size = int(n / n_folds)
        idx = nd.random.shuffle(nd.arange(n))
        folds = [nd.take(dataset, idx[i * fold_size:(i + 1) * fold_size])
                 for i in range(n_folds)]
        return nd.stack(*folds, axis=0)
    
    # Conteo de etiquetas (útil para balanceo o diagnóstico)
    @staticmethod
    def count_labels(dataset):
        """
        Devuelve un vector con el número de ocurrencias de cada clase
        (se asume que la última columna es la etiqueta).
        """
        y = dataset[:, -1].astype('int32')
        num_classes = int(nd.max(y).asscalar()) + 1
        return nd.one_hot(y, num_classes).sum(axis=0)
    
    @staticmethod
    def accuracy_metric(actual, predicted):
        cmp = (predicted.astype(actual.dtype) == actual).astype('float32')
        acc = 100 * nd.sum(cmp) / actual.size
        return f"{acc.asscalar():0.2f}"
    
    @staticmethod
    def confusion_matrix(actual, predicted):
        num_classes = int(nd.max(actual).asscalar()) + 1
        actual_1h = nd.one_hot(actual.astype('int32'), num_classes)
        pred_1h = nd.one_hot(predicted.astype('int32'), num_classes)
        matrix = nd.dot(actual_1h.T, pred_1h)
        return nd.arange(num_classes), matrix

    @staticmethod
    def print_confusion_matrix(unique, matrix):
        # Imprime una tabla simple por consola
        header = "A/P " + " ".join([str(int(x.asscalar())) for x in unique])
        print(header)
        for i, row in enumerate(matrix):
            nums = " ".join([f"{int(x.asscalar())}" for x in row])
            print(f"{int(unique[i].asscalar())}   {nums}")

    @staticmethod
    def mae_metric(actual, predicted):
        mae = nd.sum(nd.abs(actual - predicted)) / actual.size
        return f"{mae.asscalar():0.2f}"

    @staticmethod
    def rmse_metric(actual, predicted):
        mse = nd.sum((actual - predicted) ** 2) / actual.size
        return f"{nd.sqrt(mse).asscalar():0.3f}"

    @staticmethod
    def perf_metrics(actual, predicted_prob, threshold=0.5):
        """
        Calcula FPR y TPR para un umbral dado (problema binario 0/1).
        Devuelve (fpr_str, tpr_str) con 2 decimales.
        """
        predicted = (predicted_prob >= threshold).astype('int32')

        num_classes = int(nd.max(actual).asscalar()) + 1
        a1h = nd.one_hot(actual.astype('int32'), num_classes)
        p1h = nd.one_hot(predicted, num_classes)
        conf = nd.dot(a1h.T, p1h)

        tp = conf[1, 1]
        fn = conf[1, 0]
        fp = conf[0, 1]
        tn = conf[0, 0]

        tpr = tp / (tp + fn)
        fpr = fp / (fp + tn)
        return f"{fpr.asscalar():0.2f}", f"{tpr.asscalar():0.2f}"
    
    @staticmethod
    def random_algorithm(train, test):
        """
        Predicciones aleatorias basadas en las etiquetas del set de entrenamiento.
        """
        y_train = train[:, -1]
        shuffled = nd.random.shuffle(y_train)
        return shuffled[:test.shape[0]]

    @staticmethod
    def zero_rule_algorithm_classification(train, test):
        """
        Predice siempre la clase más frecuente del set de entrenamiento.
        """
        y_train = train[:, -1].astype('int32')
        num_classes = int(nd.max(y_train).asscalar()) + 1
        counts = nd.one_hot(y_train, num_classes).sum(axis=0)
        majority_class = nd.argmax(counts).asscalar()
        return nd.full((test.shape[0],), majority_class)
    