import fs from "fs";
import { Product } from "../app";

export const productsHandler = async (req: any, res: any) => {
  fs.readFile("./finalData.json", "utf8", (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error occurred while reading finalData.json");
    } else {
      const finalData = JSON.parse(data) as Product[];
      res.send(JSON.stringify(finalData, null, 2));
    }
  });
};
