#Luis Enrique Pérez Señalin
use strict; # Forza la declaración de las variables
use warnings; # Genera mensajes de error de sintaxis
use Data::Dump qw(dump); # Para la impresión de estructuras de datos

# Librerías adicionales
use List::Util qw(zip min max sum any all first none); # Reorganizar los arreglos con zip
use Tie::IxHash; # Preserva el orden de registro en arreglos asociativos

# use aliased ‘jjap::numperl' => 'np';

print "Hola Mundo!!!\n";

my $z = 0.127; # real
my $x = 3.22e-14; # real
my $c = 1567; # entero
my $d = -122; # entero

print $x;

$x = 0377; # Representación octal, equivale a 255 decimal

my $y = 0xff; # Representación hexadecimal, equivale a 255

print $x;

print sprintf("%o", $x);

print $y;

print sprintf("%X", $y);

print sprintf("%.3f", 3.14151692);

my $cadena = "Brothers\t$x\n";
print $cadena;

$cadena = 'Brothers\t$x\n';
print $cadena;

$cadena = <<SALUDO;
hola,
buenos días,
adios,
SALUDO

$x = 0;
if ($x){
  print "Verdadero";
}else{
  print "Falso";
}

$x = "";
if ($x){
  print "Verdadero";
}else{
  print "Falso";
}

my $p;
if ($p){
  print "Verdadero";
}else{
  print "Falso";
}

print dump $p;
print $p; # Muestra una advertencia, ya que $p vale undef

my @array = (); # Declaro arreglo e lo inicializo vacío
print dump @array;

print "@array";

@array = (10, 3, 7, "word");
print dump @array;

push @array, "new"; # Agrega al final del array
print "@array";

unshift @array, "beginning"; # Agrega al inicio del array
print dump @array;

splice @array, 2, 0, "between"; # Agrega en una posición arbitraria
print dump @array;

print $array[3]; # Imprimir el 3
print $#array;

print dump @array;
print $#array;

my @array2 = @array[1 .. $#array]; # Imprimir 3, 7, "word"
print "@array2";

my $cant = scalar(@array2);

print dump @array[1, 3, 5]; # Slice de posiciones impares

my $var1 = pop @array; # Retiro el elemento final del arreglo
print "var1:$var1\n";
print "array:", dump @array;

$var1 = shift @array; # Retiro el elemento inicio del arreglo
print "var1:$var1\n";
print "array:", dump @array;

@array = (1 .. 5);
$var1 = splice @array, 2, 0, (6 .. 9); # Retiro un elemento de una posición arbitraria
print "var1:$var1\n" if defined $var1;
print "array:", dump @array;

@array2 = @array; # Copia simple
@array2 = ();
print dump @array;

my $array2 = \@array; # Referencia - afecta los cambios de $array2.
@$array2 = ();
print dump @array;

@array = (1 .. 5);
push @array, @array; # Concatenar 2 listas
print "array:", dump @array;

my @list1 = (0, 1, 2);
my @list2 = (3, 4, 5);
print zip (\@list1, \@list2);

my @list3 = (@list1, @list2); # Concatenación de 2 listas simples
print "@list3";

print dump @list3; # Impresión de la lista como tal
print \@list3;

print dump zip (\@list1, \@list2);

print dump zip ([0, 2, 4], [1, 3, 5]);

$x = [0, 2, 4];
print $x;
print "@$x";

$y = [1, 3, 5];
print dump zip ($x, $y);

@list3 = map { $_->[0] + $_->[1] } zip ($x, $y);
print dump @list3;

print dump none { $_ % 3 == 0 } @list3;

my $foo = 55.23;
$foo = 'esta es una cadena';
$foo = "era $foo antes";
my $salida = `cd`;

printf "list1:%s\n", dump @list1;
my ($A, $B) = @list1;
my $suma = $A + $B;
print "Resultado: " . $suma . "\n";
print "Después de incrementar: $suma \n";
print $suma += 3;

$A = 'Mundo';
$B = 'Hola';
print "La famosa frase es $A $B!!! \n";

$cadena = "palabraA\n";
chop($cadena);
print "$cadena ya no tiene salto de fila.";

print "\U$cadena\E convertida a mayúscula.";
print "\L$cadena\E convertida a minúscula.";

my @arreglo = ();
print dump @arreglo;

print $arreglo[0];

$arreglo[0] = 5; # Cambiamos el valor de ese elemento
print $arreglo[0];

@arreglo = (1, 3, 5); # Inicializamos el arreglo
my @foo = @arreglo;      # Copiamos el arreglo
@arreglo = ();           # Limpiamos el arreglo

print "arreglo:", dump(@arreglo), "\n";
print "foo:", dump(@foo), "\n";

print dump @foo[0, 2]; # Slice del arreglo

print dump (-1 .. 3), "\n";
print dump (-2 .. -2), "\n"; # Note que incluye el último elemento.

print dump (reverse -1 .. 3);

print dump (map { $_ / 10 } -1 .. 3);

print dump (grep { $_ > 0 } -1 .. 3);

printf "Indice del último elemento de foo: %d\n", $#foo;
printf "Slice de foo: %s\n", dump @foo[0 .. $#foo];

print $foo[-1], "\n"; # Último elemento
print $foo[-2], "\n"; # Penúltimo elemento

my @A = (95, 7, 'fff');
printf "%s\n", $A[-1];
print "@A\n";

my @arreglo1 = (10, 20, 30);
my @arreglo2 = (100, 200);
my @arreglo3 = (@arreglo1, @arreglo2, 8, "es una cadena");

my $len_arreglo3 = scalar(@arreglo3);
print "Longitud del arreglo3: ", $len_arreglo3, "\n";
print "Posición del último elemento de arreglo3: ", $#arreglo3, "\n";
print "Longitud del arreglo3: ", scalar(@arreglo3), "\n";

for (my $i = 0; $i < @arreglo3; $i++) {
    printf "%d\t%s\n", $i, $arreglo3[$i];
}

print "$_\n" for @arreglo3;

for (@arreglo3) {
    printf "%s\n", $_;
}

for my $elem (@arreglo3){
    printf "%s\n", $elem;
}

foreach my $elem (@arreglo3){
    printf "%s\n", $elem;
}

while (my ($i, $elem) = each @arreglo3){
    printf "%d\t%s\n", $i, $elem;
}

@A = (2 .. 7);
my @B = ('a' .. 'e');
print "$_ " for @A;
print "\n";
print "$_ " for @B;

print 'Suma de @A: ', sum(@A);

@A = ('a' .. 'e');
$A = join ":", @A;
print $A;

my @lista = split /[A-Z]+/, "Estales2877una3frase";
print dump @lista;

my $str = "Estales2877una3fraseEscuelaPolitecnicaNacional";
my $regex = '[A-Z][a-z]*';
for my $word ($str =~ m/$regex/g){
    printf "%s ", $word;
}

@A = ('a' .. 'e');
@B = splice(@A, 1, 2);
printf "\@A: %s\n", "@A";
printf "\@B: %s\n", "@B";

@A = ('a' .. 'e');
@B = (1 .. 3);
splice(@A, 2, 0, @B);
print '@A: ', dump(@A), "\n";

@A = ('a' .. 'e');
@B = (1 .. 3);
splice(@A, 2, 0, @B);
print '@A: ', dump(@A), "\n";

my $arreglo = [ [1, 2, 3], [4, -5, 6], [7, 8, 9], [10, 11, 12] ];
print dump $arreglo;

print $arreglo; # Es una referencia

print dump $arreglo->[3];

print $arreglo->[3][1];

print dump @$arreglo[2];

print dump $arreglo->[3];

print dump @{$arreglo->[3]}[0, 2];

print dump @$arreglo[1, 3];

my $longitud = @$arreglo;
print "# filas: ", $longitud, "\n";
my $columnas = @{$arreglo->[0]};
print "# columnas: ", $columnas, "\n";

for (my $i = 0; $i < @$arreglo; $i++){
    print dump($arreglo->[$i]), "\n";
}

for (@$arreglo){
    print dump($_), "\n";
}

print dump($_), "\n" for @$arreglo;

for (my $i = 0; $i < @$arreglo; $i++){
    for (my $j = 0; $j < @{$arreglo->[$i]}; $j++){
        print $arreglo->[$i][$j], "\t";
    }
    print "\n";
}

for my $fila (@$arreglo){
    for my $cell (@$fila){
        print $cell, "\t";
    }
    print "\n";
}

@arreglo = ( [1, 2, 3], [4, -5, 6], [7, 8, 9], [10, 11, 12] );
for(my $i = 0; $i <= $#arreglo; $i++){
    for(my $j = 0; $j <= $#{$arreglo[$i]}; $j++){
        print $arreglo[$i][$j], "\t";
    }
    print "\n";
}

@lista = (
    [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
    [['a', 'b', 'c'], ['d', 'e', 'f'], ['g', 'h', 'i']],
    [[-1, -2, -3], [-4, -5, -6], [-7, -8, -9]]
);
print $lista[0][1][2], "\n"; # Imprime 6
print $lista[2][2][1], "\n"; # Imprime -8

my $array = [
    [ [1, 2, 3], [4, 5, 6], [7, 8, 9] ],
    [ ['a', 'b', 'c'], ['d', 'e', 'f'], ['g', 'h', 'i'] ],
    [ [-1, -2, -3], [-4, -5, -6], [-7, -8, -9] ]
];
print $array->[0][1][2], "\n";
print $array->[2][2][1], "\n";

my $var = shift @arreglo;
print dump $var;

$var1 = shift @$var;
print dump $var1;

@A = ('a' .. 'e');
$B = shift @A; # $B se instancia con 'a'
for (my $n = 0; $n < @A; $n++) {
    print $A[$n], " ";
}

@A = ('a' .. 'e');
$B = pop @A; # $B se instancia con 'e'
for (my $n = 0; $n < @A; $n++) {
    print $A[$n], " ";
}

unshift @A, 1; # agrega 1 al principio del arreglo
push @A, 9;    # agrega 9 al final del arreglo
for (my $n = 0; $n < @A; $n++) {
    print $A[$n], " ";
}
print "\n", "@A";

my @pila = (); # se crea la pila
my @datos = (2, 4, 6);
while (@datos) {
    unshift @pila, shift @datos; # se agrega un elemento a la pila
}
print "@datos: ", dump(@datos);
print "\n\@pila: ", dump(@pila);

@pila = (); # se crea la pila
@datos = (2, 4, 6, -1);
while (my $numero = shift @datos) {
    unshift @pila, $numero; # se agrega un elemento a la pila
}
print "\@datos: ", dump(@datos);
print "\n\@pila: ", dump(@pila);

@pila = (); # se crea la pila
@datos = (2, 4, 6, -1);
while (@datos) {
    unshift @pila, shift @datos; # se agrega un elemento a la pila
}
print "\@datos: ", dump(@datos);
print "\n\@pila: ", dump(@pila);

my $l = @pila;
for(my $i = 0; $i < $l; $i++) {
    print shift(@pila), " "; # se extrae elemento de la pila
}

my @enumerate = ('a' .. 'e');
while (my ($i, $valor) = each @enumerate){
    printf "i: %d value: %s\n", $i, $valor;
}

my %months = (
    Jan => 1, Feb => 2, Mar => 3,
    Apr => 4, May => 5, Jun => 6,
    Jul => 7, Aug => 8, Sep => 9,
    Oct => 10, Nov => 11, Dec => 12
);
print dump keys %months;

print dump values %months;

foreach my $key (keys %months){
	print "$key = $months{$key}\n";
}


tie my %months2, "Tie::IxHash";
%months2 = (
    Jan => 1, Feb => 2, Mar => 3,
    Apr => 4, May => 5, Jun => 6,
    Jul => 7, Aug => 8, Sep => 9,
    Oct => 10, Nov => 11, Dec => 12);

print dump keys %months2;

print dump values %months2;

my %stock = (); # Creamos arreglo asociativo vacio
print dump %stock;

%stock = (limones => 6, peras => 3, uvas => 2); # Creamos arreglo asociativo con datos
print dump %stock;

print $stock{peras};

$stock{peras} = 5; # Cambiamos el valor de ese elemento
print $stock{peras};

$stock{bananas} = 9; # Registro de bananas por primera vez
print dump %stock;

$stock{bananas}--; # Decrementamos el valor de bananas
print dump %stock;

$stock{bananas} -= 3; # Cambiar el valor de bananas
print dump %stock;

if (exists $stock{bananas}) {
  print "Bananas exist.\n";
} elsif (!exists $stock{bananas}) { # Equivalente a else
  print "Bananas do not exist.\n";
}

if (exists $stock{aguacates}) {
  print "Aguacates exist.\n";
} else {
  print "Aguacates do not exist.\n";
}

if (exists $stock{bananas}) {
  print dump %stock;
  # Agregar aguacates:
  $stock{aguacates} = 5;
  print "\n", dump %stock;
}

print dump [split ",", "peras, 2"];

sub alimenta_hash {
  my %stock = (); # Limpieza del arreglo asociativo
  open FILE, "../data/frutas.txt" or die("Error $!");
  while (<FILE>) {
    chomp($_);
    map {$stock{$_->[0]} = $_->[1]} [split ",", $_];
  }
  close FILE or die("Error $!");
  return \%stock;
}

my $stock = alimenta_hash();
print dump $stock;

print dump (keys %$stock);
print dump (values %$stock);

foreach my $clave (keys %$stock) {
  print "$clave = $stock->{$clave}\n";
}

while (my ($key, $value) = each(%$stock)) {
  print $key, "\t", $value, "\n";
}

undef %$stock;
print dump $stock;

%$stock = ();
print dump $stock;

#Luis Enrique Pérez Señalin
#$stock = alimenta_hash();
#foreach $clave (keys %$stock) {
#  printf "fruta: %s: %d\n", $clave, $stock->{$clave};
#}

print map "$_ = $stock->{$_}\n", keys %$stock;

while (my ($key, $valor) = each %$stock){
  print "$key = $valor\n";
}

my %A = (x => 5, y => 3, z => 'abc');
@B = keys %A;
my @v = values %A;
print "keys: @B\n";
print "values: @v\n";

my %dict = ();
map {$dict{$_->[0]} = $_->[1]} zip (\@B, \@v);
print dump %dict;

%A = (x => 5, y => 3, z => 'abc');
@v = values %A;
print "@v";

$B = exists $A{z};
$c = exists $A{w};
print dump ($B, $c);

my %hash = (
  Apples => 1,
  apples => 4,
  artichokes => 3,
  Beets => 9
);
foreach my $key (sort keys %hash) {
  print "$key = $hash{$key}\n";
}

my $monthsref = \%months;
foreach my $key (keys %$monthsref) {
  print "$key = $monthsref->{$key}\n";
}

my $meses = {
  Jan => 1, Feb => 2, Mar => 3,
  Apr => 4, May => 5, Jun => 6,
  Jul => 7, Aug => 8, Sep => 9,
  Oct => 10, Nov => 11, Dec => 12
};

print $meses->{'Jan'};

my %rev_meses = reverse %$meses;
print $rev_meses{1}, "\n";
print dump %rev_meses;

%hash = (
  Apples => [4, "Delicious red", "medium"],
  "Canadian Bacon" => [1, "package", "1/2 pound"]
);

print $hash{"Canadian Bacon"}->[1];

$hash{"Garlic"} = [4, "cloves", "medium"];

print $hash{"Garlic"}->[1]; # Imprime cloves

foreach my $key (keys %hash) {
  print "$key: \n";
  foreach my $val (@{$hash{$key}}) {
    print "\t$val\n";
  }
  print "\n";
}

map {print "$_: \n"; map {print "\t$_\n"} @{$hash{$_}}} keys %hash;

my %student = ();

$student{'maria@epn.edu.ec'}{name}   = 'Maria';
$student{'maria@epn.edu.ec'}{cedula} = 17889588534;
$student{'maria@epn.edu.ec'}{edad}   = 34;
$student{'jose@epn.edu.ec'}{name}    = 'Jose';
$student{'jose@epn.edu.ec'}{cedula}  = 17897928798;
$student{'jose@epn.edu.ec'}{edad}    = 25;

print dump %student;

foreach my $id (keys %student){
    printf "correo: %s\n", $id;
    printf "name: %s\n", $student{$id}{name};
    printf "cedula: %s\n", $student{$id}{cedula};
    printf "edad: %d\n\n", $student{$id}{edad};
}

# Definimos una referencia con la misma estructura de datos
my $student = {};

$student->{'maria@epn.edu.ec'}{name}   = 'Maria';
$student->{'maria@epn.edu.ec'}{cedula} = 17889588534;
$student->{'maria@epn.edu.ec'}{edad}   = 34;
$student->{'jose@epn.edu.ec'}{name}    = 'Jose';
$student->{'jose@epn.edu.ec'}{cedula}  = 17897928798;
$student->{'jose@epn.edu.ec'}{edad}    = 25;

print dump $student;

my $estudiante = {
    "jose\@epn.edu.ec"  => { cedula => 17897928798, edad => 25, name => "Jose" },
    "maria\@epn.edu.ec" => { cedula => 17889588534, edad => 34, name => "Maria" },
};

foreach my $id (keys %$estudiante) {
    print "$id\n";
    print $estudiante->{$id}{name}, "\n";
    print $estudiante->{$id}{cedula}, "\n";
    print $estudiante->{$id}{edad}, "\n\n";
}

# Operación Not in set:
my %ignore = map { $_ => 1 } ('c', 'ignore');
print dump (keys %ignore);

print dump grep { !exists $ignore{$_} } ('a', 'b', 'c', 'ignore');

# Operadores lógicos y aritméticos
$A = 0;
$B = 1;

print "A y B resulta verdadero\n" if $A and $B;
print "A o B resulta verdadero\n" if $A or $B;
print "A xor B resulta verdadero\n" if $A xor $B;
print "A nand B resulta verdadero\n" if not ($A and $B);

# Comparación numérica
$x = $A <=> $B;

# Comparación de strings
$x = 'aba' cmp 'abc';

# Variable indefinida
my $costo;
$costo = 100 unless $costo;
print $costo;

# Verificar si está definida
$A = 5;
$B = undef;
print "variable \$A definida con el valor $A.\n" if defined $A;
print "variable \$B no está definida.\n" if !defined $B;

my $hash = ();
if (%hash) {
    print "Variable \%hash definida.\n";
}

@array = ();
if (@array) {
    print "Variable \@array definida.\n";
}

# Concatenación
$c = $A . " " . "cadena";

# Rango
print dump (1 .. 5);

# Repetición
print '-' x 5;

@array = ('word') x 5;
print dump @array;

# Autoincremento
print $A, "\n";
$A++;
print $A, "\n";
print $A++, "\n";
print $A, "\n";

my $objeto = "tiza";
my $requerido = "tiza";
my $cantidad = 22;

if ($objeto eq "tiza") {
    print "la variable objeto esta instanciada con tiza\n";
} else {
    print "la variable objeto NO esta instanciada con tiza\n";
}

if ($cantidad <= 25) {
    print "Hay que reponer " . ((25 - $cantidad) + 3) . " elementos\n";
}

# Ejemplo if-elsif-else
my ($dividendo, $divisor, $resultado) = (4, 2);

if ($divisor == 0) {
    print STDERR "Error: no puedo dividir por cero!\n";
} elsif ($dividendo == 0){
    $resultado = $dividendo;
} elsif ($divisor == 1){
    $resultado = $dividendo;
} else {
    $resultado = $dividendo / $divisor;
}

print "El resultado es ", $resultado, "\n" if $divisor != 0;

# Ejemplo unless
my $text = "Ingrese el nombre de un sistema operativo: ";
print $text;
my $nombre = "LINUX";

if ($nombre =~ m/linux/i){
    print "Ese si es un buen producto.\n";
} else {
    print "Le pedi que ingresara un nombre de sistema operativo.\n";
}

while ($text =~ m/\b([a-z]+)\b/g){
    printf "%s\n", $1;
}

print "Escriba un numero mayor a 10.\n";
my $numero = 10;
unless ($numero > 10) {
    print "Error: $numero no es mayor a 10.\n";
} else {
    print "Número $numero es mayor a 10.\n";
}

# Ejemplo while
my ($i, $suma) = (0, 0);
while ($i < 10) {
    $suma = $suma + $i++;
}
print "El resultado de la suma es: $suma\n";

# Ejemplo do while
($i, $suma) = (0, 0);
do {
    $suma = $suma + $i++;
} while ($i < 10);
print "El resultado de la suma es: $suma\n";

# Ejemplo until
($i, $suma) = (0, 0);
until($i == 10) {
    $suma = $suma + $i++;
    print "El resultado de la suma es: $suma.\n";
    print "El valor de i es: $i.\n";
}

($i, $suma) = (0, 0);
until($i >= 10) {
    $suma = $suma + $i;
    $i++;
    print "El resultado de la suma es: $suma.\n";
    print "El valor de i es: $i.\n";
}

# Ejemplo do until
($i, $suma) = (0, 0);
do {
    $suma = $suma + $i++;
} until ($i == 10);
print "El resultado de la suma es: $suma.\n";
print "El valor de i es: $i.\n";

# Ejemplo for
$suma = 0;
for (my $i = 0; $i < 10; $i++) {
    $suma = $suma + $i;
}
print "El resultado de la suma es $suma \n";

# Ejemplo for con múltiples variables
for (my ($i, $j) = (0, 0); $i < 10; $i++, $j += 2) {
    printf "i:%d j:%d\n", $i, $j;
}

# Ejemplo foreach
@lista = (7, 11, 22, 5, 6, 7, 45);
foreach my $elemento (@lista) {
    printf "%d ", $elemento;
}
print "\n";

# Extracción de sílabas sin vocal inicial
$text = "cadena";
print join '- ', ($text =~ m/([^aeiou]+[aeiou]+)/g), "\n";

# foreach con impresión por línea
$text = "cadena";
foreach my $syl ($text =~ m/([^aeiou]+[aeiou]+)/g) {
    printf "%s\n", $syl;
}

# foreach con rango explícito
foreach my $elemento (5 .. 9) {
    print $elemento . " ";
}
print "\n";

# foreach en una línea
print $_ . " " for @lista;
print "\n";

# Ejemplo last y next
foreach my $elemento (1 .. 10) {
    print $elemento . " ";
    last if $elemento == 5;
}
print "\n";

foreach my $elemento (1 .. 10) {
    next if $elemento == 5;
    print $elemento . " ";
}
print "\n";

# Funciones y subrutinas
sub misubrutina {
    print "Soy una misubrutina.\n";
}
misubrutina();

# Función con parámetros y operador ternario
sub maximo {
    my ($var1, $var2) = @_;
    return $var1 > $var2 ? $var1 : $var2;
}

# Función con ordenamiento
sub maximo {
    return (sort { $b <=> $a } @_)[0];
}

print maximo(22, 55, 34, 75), "\n";

# Función sin return explícito
sub saludar {
    print "¡Hola $_[0]!\n";
}
saludar("Cesar");
saludar("Sandra");

# Función con hash como argumentos
sub function {
    my %args = @_;
    foreach my $key (keys %args) {
        print $key, " ", $args{$key}, "\n";
    }
}
function('var1' => 5, 'var2' => 2);

# Función con acceso individual
sub function2 {
    my %args = @_;
    print "Nombre: ", $args{nombre}, "\n";
    print "Edad: ", $args{edad}, "\n";
}
function2('nombre' => 'Maria', 'edad' => 20);

# Función con valores por defecto y validación
sub function3 {
    my %args = (enfermo => 0, @_);
    if (!defined $args{nombre}) {
        print STDERR "Argument Nombre faltante.\n";
        return;
    }
    if (!defined $args{edad}) {
        print STDERR "Argument Edad faltante.\n";
        return;
    }
    print "Nombre: ", $args{nombre}, "\n";
    print "Edad: ", $args{edad}, "\n";
    print "Enfermo: ", $args{enfermo}, "\n";
}

function3('nombre' => 'Maria', 'edad' => 20);
function3('nombre' => 'Mario');  # Argumento faltante
function3('nombre' => 'Maria', 'edad' => 20, enfermo => 1);

# Array de personas (como listas de pares clave-valor)
my @personas = (
    ['nombre' => 'Maria', 'edad' => 20],
    ['nombre' => 'Jose', 'edad' => 30]
);

foreach my $person (@personas) {
    function2(@$person);
}

# Lectura de archivo y estructura de datos
sub obtiene_frutas {
    my @stock = ();
    open FILE, "data/frutas.txt" or die("Error $!");
    while (<FILE>) {
        chomp($_);
        push @stock, map { {'fruta' => $_->[0], 'cantidad' => $_->[1]} } [split ",", $_];
    }
    close FILE or die("Error $!");
    return @stock;
}

# Mostrar contenido con otra subrutina
sub function4 {
    my %args = @_;
    print "Fruta: ", $args{fruta}, " ";
    print "Cantidad: ", $args{cantidad}, "\n";
}

my @stock = obtiene_frutas();
foreach my $fruta (@stock) {
    function4(%$fruta);
}
use Data::Dump;
print dump @stock;

# Variables locales y paso por valor
sub suma {
    my ($A, $B) = @_;
    return $A + $B;
}
print suma(2, 3), "\n";        # 5
print suma(3, 35, 22, 5), "\n"; # Solo toma los dos primeros

# Manejo de múltiples parámetros con validación
sub suma2 {
    my $s = 0;
    foreach my $x (@_) {
        if ($x !~ m/^-?\d+(?:\.\d+)?$/) {
            print STDERR "Valor '$x' no es un número válido.\n";
            return;
        }
        $s += $x;
    }
    return $s;
}
print suma2(1..8, "xa"), "\n";  # Lanza error por "xa"

# Programación Orientada a Objetos
package Empleado {
    use strict;
    use warnings;

    sub new {
        my ($class, $nombre, $email) = (shift, @_);
        my $self = {
            nombre => $nombre,
            email  => $email,
        };
        return bless($self, $class);
    }

    sub nombre {
        my ($self, $nombre) = @_;
        $self->{nombre} = $nombre if $nombre;
        return $self->{nombre};
    }

    sub email {
        my ($self, $email) = @_;
        $self->{email} = $email if $email;
        return $self->{email};
    }
    1;
}

# Herencia de clases
package Sueldo {
    use strict;
    use warnings;
    use base qw(Empleado);

    sub new {
        my ($class, $dias_trabajados, $sueldo_diario) = (shift, @_);
        my $self = {
            dias_trabajados => $dias_trabajados || 0,
            sueldo_diario   => $sueldo_diario || 0,
        };
        return bless($self, $class);
    }

    sub sueldo {
        my $self = shift;
        return $self->{dias_trabajados} * $self->{sueldo_diario};
    }
}

# Uso de las clases
my $sueldo = new Sueldo();
$sueldo->nombre('Brian');
$sueldo->email('brian@epn.edu.ec');
$sueldo->{dias_trabajados} = 22;
$sueldo->{sueldo_diario} = 20;

use Data::Dump;
print dump $sueldo;
print $sueldo->sueldo(), "\n";  # 440

my $sueldo2 = new Sueldo(18, 90);
$sueldo2->nombre('Juan');
$sueldo2->email('juan@epn.edu.ec');

print $sueldo2->sueldo(), "\n";  # 1620
print dump $sueldo2;
