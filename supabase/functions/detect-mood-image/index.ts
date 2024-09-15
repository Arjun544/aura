import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { HfInference } from 'https://esm.sh/@huggingface/inference@2.3.2';

const hf = new HfInference(Deno.env.get('HUGGING_FACE_API_KEY'))

serve(async (req) => {
  try {
    if (req.method !== 'POST') {
      return new Response(JSON.stringify({ error: 'Method Not Allowed' }), {
        status: 405,
        headers: { 'Content-Type': 'application/json' },
      });
    }




    // Read the image bytes from the request
    const formData = await req.formData();
    const file = formData.get('image');

    if (!file || !(file instanceof File)) {
      return new Response(JSON.stringify({ error: 'Image file is required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Convert image file to base64
    const reader = new FileReader();
    const imageBase64 = await new Promise<string>((resolve, reject) => {
      reader.onloadend = () => resolve(reader.result as string);
      reader.onerror = reject;
      reader.readAsDataURL(file);
    });

    // Remove the data URL prefix to get base64 string
    const base64Data = imageBase64.replace(/^data:image\/[a-z]+;base64,/, '');

    // Fetch emotion predictions from Hugging Face image classification model
    const result = await hf.imageClassification({
      inputs: base64Data,
      model: 'dima806/facial_emotions_image_detection',
    });

    // Convert score to percentage and round to 2 decimal places
    const emotions = result.map(emotion => ({
      label: emotion.label,
      score: Math.round(emotion.score * 100 * 100) / 100  // Convert to percentage
    }));

    // Find the highest scoring emotion
    const topEmotion = emotions.reduce((prev, curr) => prev.score > curr.score ? prev : curr);

    // Format the JSON response
    const response = {
      mood: topEmotion.label,
      emotions: emotions
    };

    return new Response(JSON.stringify(response), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Error processing request:', error);
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});
