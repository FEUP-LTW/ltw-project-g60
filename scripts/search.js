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
    for (let pet of pets){
        toDisplay(pet, conf)
    }
    // TODO de cada pet ir buscar os valores, comparar os valores com os de conf, mudar display
}

function toDisplay(pet, conf){
    // pet.style.display="none"
    // console.log(pet.style
    let config = Object.assign([], conf)

    if (config[0] == "")
        config[0] = pet.querySelector(".pet-details").children[3].innerHTML
    if (config[1] == ""){
        if (pet.querySelector(".pet-details").children[0].className === 'fas fa-mars')
            config[1] = "male"
        if (pet.querySelector(".pet-details").children[0].className === 'fas fa-venus')
            config[1] = "female"
    }
    if (config[2] == "")
        config[2] = pet.querySelector(".pet-details").children[1].innerHTML
    if (config[3] == "")
        config[3] = pet.querySelector(".pet-details").children[4].innerHTML

    let pet_conf = []
    pet_conf.push(pet.querySelector(".pet-details").children[3].innerHTML) // breed
    if (pet.querySelector(".pet-details").children[0].className === 'fas fa-mars')
        pet_conf.push("male")
    if (pet.querySelector(".pet-details").children[0].className === 'fas fa-venus')
        pet_conf.push("female")
    pet_conf.push(pet.querySelector(".pet-details").children[1].innerHTML) // color
    pet_conf.push(pet.querySelector(".pet-details").children[4].innerHTML) // age
    pet_conf.push(false)

    if (arraysEqual(config, pet_conf))
        pet.style.display = "grid"
    else
        pet.style.display = "none"
}

function arraysEqual(_arr1, _arr2) {
    if (
        !Array.isArray(_arr1)
        || !Array.isArray(_arr2)
        || _arr1.length !== _arr2.length
    ) {
        return false;
    }

    const arr1 = _arr1.concat().sort();
    const arr2 = _arr2.concat().sort();

    for (let i = 0; i < arr1.length; i++) {
        if (arr1[i] !== arr2[i]) {
            return false;
        }
    }

    return true;
}