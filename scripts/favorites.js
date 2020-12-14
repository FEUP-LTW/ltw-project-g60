function userFavorites() {
    let checkBox = document.getElementById("user_fav")
    let icon = document.getElementById("fav_icon")
    let pets = document.getElementsByClassName("user_pets")[0]
    let favs = document.getElementsByClassName("user_favorites")[0]

    if (checkBox.checked){
        icon.className = "fas fa-heart"
        pets.style.display = "none"
        favs.style.display = "block"
    } else {
        icon.className = "far fa-heart"
        pets.style.display = "block"
        favs.style.display = "none"
    }
}
