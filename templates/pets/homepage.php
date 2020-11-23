<header id="main-header" class="header">
    <a href="homepage.php">
        <h1>Adoption Center</h1>
    </a>
    <h2>A center to adopt</h2>
    <nav id="links">
        <a href="pets_list.html">Pets</a>
        <a href="shelters_list.html">Shelters</a>
    </nav>
    <nav id="signup">
        <a href="login.html">Login</a>
        <a href="register.html">Register</a>
    </nav>
</header>
<div class="content">
    <div class="cards" id="homepage-cards">
        <div class="card">
            <a href="#">
                <div class="card-title">Featured Pet</div>
                <img src="https://picsum.photos/200" alt="puppy photo" style="width:100%; height: auto">
                <div class="container">
                    <h4><b><?= $pets[0]['name'] ?></b></h4>
                    <p>Information</p>
                </div>
            </a>
        </div>
        <div class="card">
            <a href="#">
                <div class="card-title">Featured Shelter</div>
                <img src="https://picsum.photos/200" alt="puppy photo" style="width:100%">
                <div class="container">
                    <h4><b><?= $shelter['name'] ?></b></h4>
                    <p>Information</p>
                </div>
            </a>
        </div>
        <div class="card">
            <a href="#">
                <div class="card-title">Featured Pet</div>
                <img src="https://picsum.photos/200" alt="puppy photo" style="width:100%">
                <div class="container">
                    <h4><b><?= $pets[1]['name'] ?></b></h4>
                    <p>Information</p>
                </div>
            </a>
        </div>
    </div>
    <div id="shuffle-button">
        <a href="#" >
            <div class="button">Adopt your future Pet</div>
        </a>
    </div>
</div>