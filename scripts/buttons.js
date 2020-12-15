document.querySelectorAll('#pet_add_favorite_button').forEach(button => { //add buttons on pet_list or pet_detail
    button.addEventListener('click', addFavorite);
})

document.querySelectorAll('#pet_remove_favorite_button').forEach(button => { //add buttons on pet_list or pet_detail
    button.addEventListener('click', removeFavorite);
})

document.querySelectorAll('#pet_proposal_button').forEach(button => { //submit proposal button on pet_detail
    button.addEventListener('click', petProposal);
})

document.querySelectorAll('.reply-button').forEach(button => {
    button.addEventListener('click', overlay);
})

document.querySelectorAll('#add-comment').forEach(form => {
    form.addEventListener('submit', addComment);
})

document.querySelectorAll('#add-reply').forEach(form => {
    form.addEventListener('submit', addReply);
})

// Send message
function addFavorite(event) {
    let request = new XMLHttpRequest();

    request.open('get', 'action_add_favorite.php?' + encodeForAjax({'id': event.target.getAttribute("data-petid")}), true);
    request.send();

    confirm("Pet added to favorites!");

    //removes add button and adds remove button
    let pet_index = event.target.getAttribute("data-index");
    let pet_petid = event.target.getAttribute("data-petid");

    console.log(pet_index);

    event.target.remove();

    let remove_button = document.createElement("button");
    remove_button.setAttribute('id',"pet_remove_favorite_button");
    remove_button.setAttribute('name',"favorite");
    remove_button.setAttribute('data-index',pet_index);
    remove_button.setAttribute('data-petid',pet_petid);
    remove_button.textContent = "Remove Favorite";
    document.getElementsByClassName('buttons')[pet_index].appendChild(remove_button);
    remove_button.addEventListener('click', removeFavorite);
    event.preventDefault();
}

function removeFavorite(event) {
    let request = new XMLHttpRequest();
    request.open('get', 'action_remove_favorite.php?' + encodeForAjax({'id': event.target.getAttribute("data-petid")}), true);
    request.send();

    confirm("Pet removed from favorites!");

    let pet_index = event.target.getAttribute("data-index");
    let pet_petid = event.target.getAttribute("data-petid");

    //removes add button and adds remove button
    event.target.remove();

    let add_button = document.createElement("button");
    add_button.setAttribute('id',"pet_add_favorite_button");
    add_button.setAttribute('name',"favorite");
    add_button.setAttribute('data-index',pet_index);
    add_button.setAttribute('data-petid',pet_petid);
    add_button.textContent = "Add to Favorites";
    document.getElementsByClassName('buttons')[pet_index].appendChild(add_button);
    add_button.addEventListener('click', addFavorite);

    event.preventDefault();
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}

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

function overlay(event) {
    let el = document.getElementById("overlay");
    el.style.visibility = (el.style.visibility === "visible") ? "hidden" : "visible";
    document.getElementById("add-reply").setAttribute("data-comment-id", event.target.getAttribute("data-comment-id"))
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

function addReply(event) {
    let user_id = document.querySelector('#add-reply #reply-user_id').value;
    let text = document.querySelector('#add-reply #reply-text').value;
    let type = document.querySelector('#add-reply #reply-type').value;

    // Delete sent message
    document.querySelector('#add-reply #reply-text').value='';
    // Send message
    let request = new XMLHttpRequest();
    request.open('get', 'action_add_reply.php?' + encodeForAjax({'comment_id': event.target.getAttribute("data-comment-id"), 'text': text, 'user_id': user_id, 'type': type}), true);
    request.send();

    let el = document.getElementById("overlay");
    el.style.visibility = "hidden";

    event.preventDefault();
}