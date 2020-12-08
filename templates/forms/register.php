<div class="content">
    <section id="register">
        <h2>Register</h2>
        <form action="action_register.php" method="post" enctype="multipart/form-data">
            <label>Name
                <input type="text" name="name" placeholder="Full Name">
            </label>
            <label>Username
                <input type="text" name="username" placeholder="no spaces">
            </label>
            <div id="photos">
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Profile photo
                    <input hidden type="file" class="button" name="profile_photo">
                </label>
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Header photo
                    <input hidden type="file" class="button" name="header_photo">
                </label>
            </div>
            <label>Password
                <input type="password" name="password" placeholder="min. 8 characters">
            </label>
            <label>Confirm Password
                <input type="password" name="password" placeholder="confirm your password">
            </label>
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