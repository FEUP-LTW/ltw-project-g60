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

function petProposal() {
    let checkBox = document.getElementById("pet_proposal")
    let proposals = document.getElementById("proposals")
    let comments = document.getElementById("pet-comments")
    let make_proposal = document.getElementById("make_proposal")

    if (checkBox.checked){
        proposals.style.display = "none"
        comments.style.display = "none"
        make_proposal.style.display = "block"
    } else {
        make_proposal.style.display = "none"
        proposals.style.display = "block"
        comments.style.display = "block"
    }
}
