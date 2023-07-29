import express, { Request, Response } from "express";
import fs from "fs";
const app = express();
const port = 3000;

interface Product {
  store: string;
  id: string;
  name: string;
  description: string;
  price: number;
  priceHistory: { date: string; price: number }[];
  isWeighted: boolean;
  unit: string;
  quantity: number;
  bio: boolean;
  category: string;
  unavailable: boolean;
}

interface TransformedProduct {
  id: string;
  store: string;
  name: string;
  description: string;
  price: number;
  priceHistory: { date: string; price: number }[];
  unit: string;
  quantity: number;
}

interface TransformedProductWithCategory extends TransformedProduct {
  category?: string;
}

const ids = [
  // Red Bull
  "00-12494", // billa
  "151238", // spar
  548526, // hofer RED BULL Energy Drink 250ml
  // tomatoes
  "00-374991", // billa clever geschaelte tomaten
  "2103617", // spar sbduget
  546133, // hofer passierte tomaten
  // Joghurt
  "00-668140", // billa Clever Joghurt Natur
  546469, //hofer MILFINA Cremiges Fettarmes Naturjoghurt 0,1% Fett 250g
  "2729497", //Spar NÖM Natur Joghurt 1 % Fett löffelfes
  // Spaghetti
  "00-379560", // billa clever
  "7365270", // spar DESPAR Spaghetti n° 5
  546368, // hofer CUCINA NOBILE Spaghetti 1kg
  // Butter
  "3215098", // spar Pinzgau Milch Bergbauern Butter 82% Fett
  "00-827690", // billa Ja! Natürlich Bio-Butter"
  546430, // hofer MILFINA Teebutter 250g,
  // milch
  "5048854", // spar NÖM Guten Morgen Milch 1,8 % Fett länger frisch"
  "00-432809", // billa nöm Guten Morgen Milch 1.8%"
  546088, // hofer MILFINA Leichte Milch 1l
  // Sonnenblumen
  "2020002496678", // spar Osolio Reines Sonnenblumenöl"
  "00-918428", // billa BILLA Sonnenblumenöl
  545932, // hofer BELLASAN Natives kaltgepresstes Sonnenblumenöl 500ml"
  // Toilettenpapier
  "8185433", // spar Cosy Toilettenpapier 10 Rollen
  "00-431244", // billa BILLA Toilettenpapier Sensitiv
  546139, // hofer KOKETT Comfort Toilettenpapier 3-lagig 180 Blatt Rollen 10 Stück
  // Äpfel
  "6737634", // spar SPAR Natur*pur Bio-Äpfel Arlet per kg
  "00-804413", // billa Wunderlinge Äpfel aus Österreich
  545173, // hofer HOFER MARKPLATZ Äpfel gelb"
  // Bananen
  "6942526", // spar S-BUDGET Bananen per kg
  "00-258074", // billa Clever Bananen aus Kolumbien
  545162, // hofer HOFER MARKTPLATZ Bananen
  // Faschiertes
  "2020002281397", // spar S-BUDGET Faschiertes gemischt per Packung
  "00-317050", // billa Clever Faschiertes gemischt
  546468, // hofer GENUSS 100% AUS ÖSTERREICH Frisches Faschiertes mit 50% Schweinefleisch 500g
  // Toastbrot
  "7088087", // spar S-BUDGET Toastbrot
  "00-425504", // billa Clever Weizentoast
  544863, // hofer HAPPY HARVEST Weizen Toastbrot 500g
  // Crossaints
  "7615153", // spar S-BUDGET Buttercroissant 1 STK
  "00-440691", // billa Butterlaugencroissant
  546069, // hofer BACKBOX Buttercroissant 63g
  // Orangensaft
  "7354236", // spar S-BUDGET Orangennektar aus Orangensaftkonzentrat, 50%
  "00-861713", // billa Clever Orangensaft
  548597, // hofer RIO D´ORO Orangensaft 1l
];

const names = [
  "Tomaten",
  "Joghurt",
  "Spaghetti",
  "Butter",
  "Milch",
  "Sonnenblumenöl",
  "Toilettenpapier",
  "Äpfel",
  "Bananen",
  "Faschiertes",
  "Energy Drink",
  "Toast",
  "Croissant",
  "Orangensaft",
];

const stores = ["billa", "hofer", "spar"];

app.get("/", (req: Request, res: Response) => {
  res.send("Hello World!");
});

app.get("/ids", (req: Request, res: Response) => {
  fs.readFile("./filteredDataIds.json", "utf8", (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error occurred while reading filteredDataIds.json");
    } else {
      const dataArray = JSON.parse(data) as Product[];

      const getCalcUnit = (unit: string) => {
        if (unit === "stk") return "stk";
        if (unit === "g") return "kg";
        if (unit === "ml") return "l";
        return unit;
      };

      function addCategory(
        products: TransformedProduct[]
      ): TransformedProductWithCategory[] {
        return products.map((product) => {
          let productWithCategory: TransformedProductWithCategory = {
            ...product,
          };
          for (const name of names) {
            if (product.name.toLowerCase().includes(name.toLowerCase())) {
              productWithCategory.category = name;
              break;
            }
          }
          return productWithCategory;
        });
      }

      function transformProductData(products: Product[]): TransformedProduct[] {
        return products.map((product) => {
          return {
            id: product.id,
            store: product.store,
            name: product.name,
            description: product.description,
            price: product.price,
            priceHistory: product.priceHistory.slice(0, 5),
            unit: product.unit,
            quantity: product.quantity,
            calcPricePerUnit:
              product.unit === "stk"
                ? product.price
                : (product.price / product.quantity) * 1000,
            calcUnit: getCalcUnit(product.unit),
          };
        });
      }

      const transformedData = transformProductData(dataArray);
      const finalData = addCategory(transformedData);

      fs.writeFile(
        "finalData.json",
        JSON.stringify(finalData, null, 2),
        "utf8",
        (err) => {
          if (err) {
            console.log("An error occurred while writing JSON Object to File.");
            return console.log(err);
          }
        }
      );

      res.send("Hello data!");
      //res.send(JSON.parse(data));
    }
  });
});

app.get("/products", (req: Request, res: Response) => {
  console.log("ids.length", ids.length);
  fs.readFile("./data.json", "utf8", (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error occurred while reading the file.");
    } else {
      const dataArray = JSON.parse(data) as Product[];

      // filter by IDs
      const filteredDataIds = dataArray.filter((item) => ids.includes(item.id));
      //console.log("filteredDataIds.length: ", filteredDataIds.length);

      const missingIds = ids.filter(
        (id) => !filteredDataIds.find((item) => item.id === id)
      );

      //console.log("missingIds: ", missingIds);

      fs.writeFile(
        "filteredDataIds.json",
        JSON.stringify(filteredDataIds, null, 2),
        "utf8",
        (err) => {
          if (err) {
            console.log("An error occurred while writing JSON Object to File.");
            return console.log(err);
          }
        }
      );

      // filter by names and stores
      const filteredData = dataArray.filter(
        (item) =>
          names.some((name) => item.name.includes(name)) &&
          stores.includes(item.store)
      );
      fs.writeFile(
        "filteredData.json",
        JSON.stringify(filteredData, null, 2),
        "utf8",
        (err) => {
          if (err) {
            console.log("An error occurred while writing JSON Object to File.");
            return console.log(err);
          }
          console.log(
            "JSON file has been saved. length: ",
            filteredData.length
          );
        }
      );
      console.log("data", dataArray.length);
      console.log("dataFiltered", filteredData.length);
      res.send("Hello data!");
      //res.send(JSON.parse(data));
    }
  });
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
