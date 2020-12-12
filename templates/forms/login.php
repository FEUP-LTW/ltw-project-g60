<div class="content">
    <section id="login">
        <h2>Login</h2>
        <form action="action_login.php" method="post">
            <div class="group">
                <input id="username" name="username" type="text" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="username">Username</label>
            </div>
            <div class="group">
                <input id="password" name="password" type="password" required>
                <span class="highlight"></span>
                <span class="bar"></span>
                <label for="password">Password</label>
            </div>
            <input hidden type="submit" class="button" value="Login">
        </form>
    </section>
</div>