//script.js
function saludar(){
    const nombre = prompt("Como te llamas");
    const mensaje = `Hola, ${nombre}! Bienvenido al 
    laboratorio de Javascript`;
    document.getElementById("resultado").innerText = mensaje;
}

function sumar(){
    const n1 = parseFloat(document.getElementById("num1").value)
    const n2 = parseFloat(document.getElementById("num2").value)
    let suma = n1+n2
    document.getElementById("resultadoSuma").innerText = `Resultado ${suma}`;
}

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