window.addEventListener('message', function(event) {
    if (event.data.action === 'openMenu') {
        const drinksContainer = document.getElementById('drinks');
        drinksContainer.innerHTML = '';  // Clear any existing drinks

        event.data.drinks.forEach(drink => {
            const drinkElement = document.createElement('div');
            drinkElement.classList.add('drink');
            drinkElement.innerText = `${drink.label} ($${drink.price})`;
            drinkElement.addEventListener('click', function() {
                fetch(`https://${GetParentResourceName()}/selectDrink`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ item: drink.item, price: drink.price })
                });
            });
            drinksContainer.appendChild(drinkElement);
        });

        document.getElementById('sodaFountainUI').style.display = 'flex';  // Zeige das UI an
    }

    if (event.data.action === 'closeMenu') {
        document.getElementById('sodaFountainUI').style.display = 'none';  // Verstecke das UI
    }
});

document.getElementById('closeMenu').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    });
    document.getElementById('sodaFountainUI').style.display = 'none';  // Verstecke das UI bei Klick auf "Close"
});
