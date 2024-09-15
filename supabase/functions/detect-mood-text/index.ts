import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { HfInference } from 'https://esm.sh/@huggingface/inference@2.3.2'

// Initialize Hugging Face Inference with API Key
const hf = new HfInference(Deno.env.get('HUGGING_FACE_API_KEY'))


// Serve the request
serve(async (req) => {
  try {
    // Only accept POST requests
    if (req.method !== 'POST') {
      return new Response(JSON.stringify({ error: 'Method Not Allowed' }), {
        status: 405,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Parse the JSON body
    const { text } = await req.json();

    if (!text) {
      return new Response(JSON.stringify({ error: 'Text input is required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Call the Hugging Face Inference API to get emotions
    const result = await hf.textClassification({
      inputs: text,
      model: 'michellejieli/emotion_text_classifier'
    });

    // Convert score to percentage and round it to 2 decimal places
    const emotions = result.map(emotion => ({
      label: emotion.label,
      score: Math.round(emotion.score * 100 * 100) / 100  // Convert to percentage and round to 2 decimal places
    }));

    // Find the highest scoring emotion
    const topEmotion = emotions.reduce((prev, curr) => prev.score > curr.score ? prev : curr);

    // Format the JSON response
    const response = {
      mood: topEmotion.label,
      score: topEmotion.score,
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
