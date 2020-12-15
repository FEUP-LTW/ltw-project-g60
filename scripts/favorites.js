
document.querySelectorAll("#user_fav").forEach(button=>{
    button.addEventListener("click", userFavorites)
})

function userFavorites() {
    let checkBox = document.getElementById("user_fav")
    let icon = document.getElementById("fav_icon")
    let pets = document.getElementsByClassName("user_pets")[0]
    let favs = document.getElementsByClassName("user_favorites")[0]


