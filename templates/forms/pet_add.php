<div class="content">
    <section id="pet_add">
        <section id="left">
            <h2>Give us the details about your pet!</h2>
        </section>
        <section id="right">
            <form action="action_addpet.php" method="post" enctype="multipart/form-data">
                <label>Name
                    <input type="text" name="name" placeholder="Pet's name">
                </label>
                <label>Breed
                    <input type="text" name="breed" placeholder="Pet's breed">
                </label>
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Choose a photo
                    <input hidden type="file" name="photo" id="Pet-photo">
                </label>
                <label>Size
                    <input type="number" name="size" placeholder="Pet's size">
                </label>
                <label>Color
                    <input type="text" name="color" placeholder="Pet's color">
                </label>
                <label>Age
                    <input type="number" name="age" placeholder="Pet's age">
                </label>
                <label>Location
                    <input type="text" name="location" placeholder="Pet's location">
                </label>
                <input type="submit" class="button" id="addButton" value="Add Pet!">
                <div id="gender-option">
                    <label>Male
                        <input type="radio"  name="gender" value="male" checked="checked">
                        <span class="checkmark"></span>
                    </label>
                    <label>Female
                        <input type="radio"  name="gender" value="female">
                        <span class="checkmark"></span>
                    </label>
                </div>
                <label>Information
                    <textarea id="petInfo" name="information" placeholder="Pet's info"></textarea>
                </label>
                <select name="status">
                    <option value="" disabled selected>Status</option>
                    <option value="">prepared</option>
                </select>
            </form>
        </section>
    </section>
</div>