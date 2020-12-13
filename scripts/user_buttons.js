function editUserInfo() {
    let checkBox = document.getElementById("about_me_check")
    let icon = document.getElementById("abt_icon")
    let pets = document.getElementsByClassName("user_pets")[0]
    let aboutme = document.getElementsByClassName("edit_user_info")[0]

    if (checkBox.checked){
        icon.className = "fas fa-file"
        pets.style.display = "none"
        aboutme.style.display = "block"
    } else {
        icon.className = "far fa-file"
        pets.style.display = "block"
        aboutme.style.display = "none"
    }
}

function editShelterInfo() {
    let checkBox = document.getElementById("about_me_check")
    let icon = document.getElementById("abt_icon")
    let pets = document.getElementsByClassName("shelter_adoption")[0]
    let aboutme = document.getElementsByClassName("edit_shelter_info")[0]

    if (checkBox.checked){
        icon.className = "fas fa-file"
        pets.style.display = "none"
        aboutme.style.display = "block"
    } else {
        icon.className = "far fa-file"
        pets.style.display = "block"
        aboutme.style.display = "none"
    }
}