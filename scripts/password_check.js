document.querySelectorAll('#password').forEach(password => { //add buttons on pet_list or pet_detail
    password.addEventListener("change", validatePassword)
})
document.querySelectorAll('#confirm-password').forEach(password => { //add buttons on pet_list or pet_detail
    password.addEventListener("keyup", validatePassword)
})
var password = document.getElementById("password")
    , confirm_password = document.getElementById("confirm-password");
function validatePassword(){
    if(password.value != confirm_password.value) {
        confirm_password.setCustomValidity("Passwords Don't Match");
    } else {
        confirm_password.setCustomValidity('');
    }
}
