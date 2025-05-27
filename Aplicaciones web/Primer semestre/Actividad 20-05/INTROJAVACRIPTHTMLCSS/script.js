//Saludar
function saludar(){
    const nombre = document.getElementById("nombre").value;
    const mensaje = `Hola, ${nombre}! Bienvenido a 
    la página de Enrique Pérez`;
    document.getElementById("resultadoSaludo").innerText = mensaje;
}

//Sumar
function sumar(){
    const n1 = parseFloat(document.getElementById("num1").value)
    const n2 = parseFloat(document.getElementById("num2").value)
    let suma = n1+n2
    document.getElementById("resultadoSuma").innerText = `Resultado ${suma}`;
}

//Generar tabla
function generar(){
    const num = parseInt(document.getElementById("tablaNum").value);
    const lista = document.getElementById("resultadoTabla");
    lista.innerHTML="";
    for(let i=1; i<=10; i++){
        const li = document.createElement("li")
        li.textContent = `${num} X ${i} = ${num * i}`;
        lista.appendChild(li)
    }
}

//Calcular promedio
function promedio(){
    const nota1 = parseFloat(document.getElementById("nota1").value)
    const nota2 = parseFloat(document.getElementById("nota2").value)
    const nota3 = parseFloat(document.getElementById("nota3").value)
    let promedio = (nota1+nota2+nota3)/3
    document.getElementById("resultadoPromedio").innerText = `El promedio es: ${promedio}`;
}

//Función para agregar tareas
function agregarTarea(){
    const input = document.getElementById("tareaInput");
    const texto = input.value.trim();
    if (texto === "") return;

    const li = document.createElement("li");
    li.textContent=texto;
    li.onclick = () => li.classList.toggle("completada");

    const bnt = document.createElement("button");
    bnt.textContent="X";
    bnt.onclick = () => li.remove();

    li.appendChild(bnt)

    document.getElementById("listaTareas").appendChild(li);
    input.value="";

}