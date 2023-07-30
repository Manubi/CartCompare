import { Request, Response } from "express";
import fs from "fs";
import { Product } from "../app";

// Read products from precomputed finalData.json file
// TODO: refactor as soon as data is cleaned up
export const productsHandler = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const data = await fs.promises.readFile("./finalData.json", "utf8");
    const finalData = JSON.parse(data) as Product[];
    res.send(JSON.stringify(finalData, null, 2));
  } catch (err) {
    console.error(err);
    res.status(500).send("Error occurred while reading finalData.json");
  }
};
