class Product {
  id;
  image;
  name;
  rating;
  priceCents;
  keywords;

  constructor(productDetails) {
    this.id = productDetails.id;
    this.image = productDetails.image;
    this.name = productDetails.name;
    this.rating = productDetails.rating;
    this.priceCents = productDetails.priceCents;
    this.keywords = productDetails.keywords;
  }

  extraInfoHTML(){
    return '';
  }
}

class Clothing extends Product {
  sizeChartLink;

  constructor(productDetails) {
    super(productDetails);
    this.sizeChartLink = productDetails.sizeChartLink;
  }

  extraInfoHTML() {
    return `
      <a href="${this.sizeChartLink}" target="_blank">Size Chart</a>
    `;
  }
}



export let products = [];

export function loadProductsFetch() {
  const promise = fetch('https://supersimplebackend.dev/products').then((response)=>{
    return response.json();
  }).then((productsData)=>{
    products = productsData.map((productDetails) => {
      if (productDetails.type === 'clothing') {
        return new Clothing(productDetails);
      }
      return new Product(productDetails)
    });
    console.log('products loaded');
  });

  return promise
}

export function findMatch(productId) {
  let match;
  products.forEach((product)=>{
    if (productId === product.id) {
      match = product;
    }
  });
  return match
}

export function searchEngine(phrase) {
  const phraseList = phrase.toLowerCase().split(" ");
  if (phrase === '') {
    return undefined;
  }

  let results = []
  products.forEach((product) => {
    let value = 0;
    let fullKeyWord;
    product.keywords.forEach((word) => {
      fullKeyWord += `${word.toLowerCase()} `;
    });
    const productName = product.name.toLowerCase();

    phraseList.forEach((word) => {
      if (productName.includes(word)) {
        value++;
      }
      if (fullKeyWord.includes(word)) {
        value++;
      }
    });
    

    if (value > 0) {
      insert(results, product, value);
    }
  });

  results = results.map((product) => {
    return product.item;
  });
  return results.slice(0,20);
}

function insert(prevList, item, value) {
  let total = prevList.length;
  let cur = 0;

  while (cur < total) {
    if (prevList[cur].value < value) {
      break;
    }
    cur++;
  }
  prevList.splice(cur, 0, {item, value});
}