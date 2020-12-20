<div class="content">
    <section id="register">
        <h2>Register</h2>
        <form action="../actions/action_register.php" method="post" enctype="multipart/form-data">
            <input id="csrf_var" type="hidden" name="csrf" value="<?=$_SESSION['csrf']?>">
            <div class="group">
                <input id="name" name="name" type="text" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="name">Full Name</label>
            </div>
            <div class="group">
                <input id="username" name="username" type="text" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="username">Username</label>
            </div>
            <div id="photos">
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Profile
                    <input hidden type="file" class="button" name="profile_photo">
                </label>
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Header
                    <input hidden type="file" class="button" name="header_photo">
                </label>
            </div>
            <div class="group">
                <input id="password" name="password" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="password">Password</label>
            </div>
            <div class="group">
                <input id="confirm-password" name="confirm-password" type="password" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="confirm-password">Confirm Password</label>
            </div>
            <input type="submit" class="button" value="Register">
            <div id="shelter-user-option">
                <label>User
                    <input type="radio"  name="usertype" value="user" checked="checked">
                    <span class="checkmark"></span>
                </label>
                <label>Shelter
                    <input type="radio"  name="usertype" value="shelter">
                    <span class="checkmark"></span>
                </label>
            </div>
        </form>
    </section>
</div>