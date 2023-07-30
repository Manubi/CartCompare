import "dotenv/config";
import { Request as ExpressRequest, Response } from "express";
import { Configuration, OpenAIApi } from "openai";

export interface ChatRequestBody {
  message: string;
}
interface Request extends ExpressRequest {
  body: ChatRequestBody;
}

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY ?? "",
});
const openai = new OpenAIApi(configuration);

//TODO: write prompt for the feature 'meal recommendations'
export const chatHandler = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { message } = req.body as ChatRequestBody;
  try {
    const chatCompletion = await openai.createChatCompletion({
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: message }],
    });
    console.log(chatCompletion.data.choices[0].message);

    const chatResponse = chatCompletion.data.choices[0].message;

    res.json({ response: chatResponse });
  } catch (error) {
    res.status(500).json({ error: "Error processing chatGPT message" });
  }
};
