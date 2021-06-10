function profit_calculation(){
const item_price = document.getElementById("item-price");
item_price.addEventListener("input", () => {
  const add_tax_price = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  const sales = 0.1;
  const commission = item_price.value * sales;
  add_tax_price.innerHTML = commission;
  profit.innerHTML = item_price.value - commission;
});
};

window.addEventListener("load", profit_calculation);