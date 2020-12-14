document.querySelectorAll('#pet_favorite_button').forEach(button => { //add buttons on pet_list or pet_detail
    button.addEventListener('click', addFavorite);
})

document.querySelectorAll('#pet_proposal_button').forEach(button => { //submit proposal button on pet_detail
    button.addEventListener('click', petProposal);
})

document.querySelectorAll('.reply-button').forEach(button => {
    button.addEventListener('click', overlay);
})

document.getElementById('add-comment').addEventListener('submit', addComment)

// Send message
function addFavorite(event) {
    confirm("Pet added to favorites!");

    // Send
    let request = new XMLHttpRequest();
    request.open('get', 'action_add_favorite.php?' + encodeForAjax({'id': event.target.getAttribute("data-petid") }), true);
    request.send();

    event.preventDefault();
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}

function petProposal() {
    let proposals = document.getElementById("proposals")
    let comments = document.getElementById("pet-comments")
    let make_proposal = document.getElementById("make_proposal")

    if (proposals.style.display !== "none"){
        proposals.style.display = "none"
        comments.style.display = "none"
        make_proposal.style.display = "block"
    } else {
        make_proposal.style.display = "none"
        proposals.style.display = "block"
        comments.style.display = "block"
    }
}

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

function overlay() {
    let el = document.getElementById("overlay");
    el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}

function addComment(event) {
    let user_id = document.querySelector('#add-comment #user_id').value;
    let pet_id = document.querySelector('#add-comment #user_id').value;
    let text = document.querySelector('#add-comment #text').value;

    // Delete sent message
    document.querySelector('#add-comment #text').value='';
    // Send message
    let request = new XMLHttpRequest();
    request.open('get', 'action_add_comment.php?' + encodeForAjax({'pet_id': pet_id, 'user_id': user_id, 'text': text}), true);
    request.send();

    event.preventDefault();
}