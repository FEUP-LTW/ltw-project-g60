document.querySelectorAll('#choice').forEach(selector=>{
    selector.addEventListener("change", Filter)
})

function Filter(event){
    // Percorre a lista e todos os pets que não sejam dessa breed ficam ocultos
    console.log(event.target.value)
    console.log(getConf())
    setResults(getConf())
}

function getConf(){
    let conf = []
    conf.push(document.querySelectorAll('#choice')[0].value)
    conf.push(document.querySelectorAll('#choice')[1].value)
    conf.push(document.querySelectorAll('#choice')[2].value)
    conf.push(document.querySelectorAll('#choice')[3].value)
    conf.push(document.querySelectorAll('#choice')[4].checked)
    return conf
}

function setResults(conf){
    let a = document.getElementsByClassName("pets-list")[0]
    let pets = a.getElementsByClassName("pet-card")
    for (let pet of pets)
        console.log(pet)
    // TODO de cada pet ir buscar os valores, comparar os valores com os de conf, mudar display
}