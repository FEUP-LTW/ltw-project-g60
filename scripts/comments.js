//------------------- PET DETAIL COMMENTS ----------------------//
document.querySelectorAll('#add-comment').forEach(form => {
    form.addEventListener('submit', addComment);
})

document.querySelectorAll('#add-reply').forEach(form => {
    form.addEventListener('submit', addReply);
})

let inPetProfile = document.querySelector('#pet-profile');
let count_comments = document.createElement('h2');

if (inPetProfile != null) { //checks if we are in pet profile
    var last_comment_id = -1;
    var last_reply_id = -1;
    var n_comments = 0;
    window.setInterval(refresh, 5000);
    refresh();
}

// Ask for new messages
function refresh() {
    let pet_id = document.querySelector("#pet-comments" ).getAttribute('data-petid');
        let request = new XMLHttpRequest();
        request.open('get', 'action_add_comment.php?' + encodeForAjax({'last_id': last_comment_id, 'pet_id': pet_id}), true);
        request.addEventListener('load', commentsReceived);
        request.send();
}

function addComment(event) {
    let user_id = document.querySelector('#add-comment #user_id').value;
    let pet_id = document.querySelector('#add-comment #pet_id').value;
    let text = document.querySelector('#add-comment #text').value;
    // Delete sent message
    document.querySelector('#add-comment #text').value='';
    // Send message
    let request = new XMLHttpRequest();
    request.open('get', 'action_add_comment.php?' + encodeForAjax({'last_id': last_comment_id, 'pet_id': pet_id, 'user_id': user_id, 'text': text}), true);
    request.addEventListener('load', commentsReceived);
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
    request.open('get', 'action_add_reply.php?' + encodeForAjax({'last_id': last_reply_id, 'comment_id': event.target.getAttribute("data-comment-id"), 'text': text, 'user_id': user_id, 'type': type}), true);
    request.addEventListener('load', repliesReceived);
    request.send();

    let el = document.getElementById("overlay");
    el.style.visibility = "hidden";

    event.preventDefault();
}

// Called when messages are received
function commentsReceived() {
    let comments = document.getElementById("pet-comments");
    let session = document.querySelector("#pet-comments" ).getAttribute('data-session');

    let comment_ids = [];
    let lines = JSON.parse(this.responseText);
    n_comments += lines.length;
    count_comments.innerText = n_comments + " Comments";

    lines.forEach(function(data){
        let line = document.createElement('div');
        line.setAttribute('class',"pet-comment");
        line.setAttribute('data-commentid',data.id);

        comment_ids.push(data.id);

        line.innerHTML = "<a href=\"user_profile.php?id=" + data.user_id +
            " \" class=\"user-image\"" +
            "style=\"background-image: url('database/images/users/profile/thumbs_medium/" +
            data.user_id + ".jpg')\"></a>" +
            "<span class=\"user\"><a href=\"user_profile.php?id=" + data.user_id + "\">" + data.name +
            "</a></span>" +
            "<span class=\"date\">" + data.time + "</span>" +
            "<p>" + data.text + "</p>";

        if(session){
            line.innerHTML += "<button class=\"reply-button\" data-comment-id=\"" + data.id + "\">Reply</button>";
            line.querySelector('.reply-button').addEventListener('click', overlay);
        }

        comments.prepend(line);

        request.open('get', 'action_add_reply.php?' + encodeForAjax({'last_id': last_reply_id, 'comment_id': data.id}), false);
        request.addEventListener('load', repliesReceived);
        request.send();

    });

    if (comment_ids.length > 0)
        last_comment_id = Math.max(...comment_ids);

    comments.prepend(count_comments);
}

// Called when messages are received
function repliesReceived() {
    let comments = document.getElementById("pet-comments");

    let replies_ids = [];
    let lines = JSON.parse(this.responseText);
    lines.forEach(function(data){
        let line = document.createElement('div');
        line.setAttribute('class',"pet-answer");

        replies_ids.push(data.id);

        if (data.type === "user") {
            line.innerHTML = "<a href=\"user_profile.php?id=" + data.user_id +
                " \" class=\"user-image\"" +
                "style=\"background-image: url('database/images/users/profile/thumbs_medium/" +
                data.user_id + ".jpg')\"></a>" +
                "<span class=\"user\"><a href=\"user_profile.php?id=" + data.user_id + "\">" + data.name +
                "</a></span>" +
                "<span class=\"date\">" + data.time + "</span>" +
                "<p>" + data.text + "</p>";
        }else{
            line.innerHTML = "<a href=\"shelter_profile.php?id=" + data.user_id +
                " \" class=\"user-image\"" +
                "style=\"background-image: url('database/images/shelters/profile/thumbs_medium/" +
                data.user_id + ".jpg')\"></a>" +
                "<span class=\"user\"><a href=\"shelter_profile.php?id=" + data.user_id + "\">" + data.name +
                "</a></span>" +
                "<span class=\"date\">" + data.time + "</span>" +
                "<p>" + data.text + "</p>";
        }
        comments.insertBefore(line,comments.querySelector("[data-commentid = \"" + data.comment_id + "\"]").nextSibling );
    });

    if (replies_ids.length > 0)
        last_reply_id = Math.max(...replies_ids);
}

function overlay(event) {
    let el = document.getElementById("overlay");
    el.style.visibility = (el.style.visibility === "visible") ? "hidden" : "visible";
    document.getElementById("add-reply").setAttribute("data-comment-id", event.target.getAttribute("data-comment-id"))
}