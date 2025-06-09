//Simula la función para obtener una url de una imagen

function getImagenUrl(person){
    return `https://via.placeholder.com/100?text=${encodeURIComponent(person.name.split(' ')[0])}`;
}
//lista de personas con datos
const people =[
    {
        id: 0,
        name: 'Creola Katherine Johnson',
        profession: 'mathematician',
        accomplishment: 'calculating trajectories for NASA missions'
      },
      {
        id: 1,
        name: 'Mario José Molina-Pasquel Henríquez',
        profession: 'chemist',
        accomplishment: 'discovering ozone depletion'
      },
      {
        id: 2,
        name: 'Mohammad Abdus Salam',
        profession: 'physicist',
        accomplishment: 'contributions to electroweak unification'
      },
      {
        id: 3,
        name: 'Percy Lavon Julian',
        profession: 'chemist',
        accomplishment: 'pioneering work in chemical synthesis'
      },
      {
        id: 4,
        name: 'Subrahmanyan Chandrasekhar',
        profession: 'astrophysicist',
        accomplishment: 'theory of black holes and stellar evolution'
      }
];


export default function ListaQuimicos(){
    const chemist=people.filter(person => person.profession === 'chemist')
    const listItems = chemist.map(person=> (
        <li key={person.id}>
            <img src={getImagenUrl(person)} 
                alt={person.name}
                width={100} />
            <p>
                <b>{person.name}</b> : {person.profession}
                Conocido por: {person.accomplishment}
            </p>
        </li>
    ))
    return(
        <div>
            <h3>Cientificos Quimicos</h3>
            <ul>{listItems}</ul>
        </div>
    )
}