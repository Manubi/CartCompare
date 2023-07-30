const { Configuration, OpenAIApi } = require("openai");
import "dotenv/config";

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY ?? "",
});
const openai = new OpenAIApi(configuration);

interface ChatRequestBody {
  message: string;
}

export const chatHandler = async (req: any, res: any) => {
  const { message } = req.body;

  if (!message) {
    return res.status(400).json({ error: "Message is required" });
  }

  try {
    const chatCompletion = await openai.createChatCompletion({
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: message }],
    });
    console.log(chatCompletion.data.choices[0].message);

    const chatResponse = chatCompletion.data.choices[0].message;

    res.json({ response: chatResponse });
  } catch (error) {
    res.status(500).json({ error: "Error processing chat message" });
  }
};
