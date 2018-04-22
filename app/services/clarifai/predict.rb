module Clarifai
  class Predict
    # https://clarifai.com/models/general-image-recognition-model-aaa03c23b3724a16a56b629203edc62c
    GENERAL_IMAGE_RECOGNITION_MODEL = 'aaa03c23b3724a16a56b629203edc62c'

    def self.predict(url) # TODO expand to multiple urls
      data = { "inputs": [{ "data": { "image": { "url": url } } }] }
      response = Clarifai::Request.outputs(GENERAL_IMAGE_RECOGNITION_MODEL, data.to_json)
      Predict.new(JSON.parse(response.body))
    end

    attr_reader :response

    def initialize(response)
      @data = response['outputs'][0]['data'] # TODO only first do multiple
      @response = response
    end

    def concepts
      @data['concepts']
    end

    def tags
      concepts.map { |concept| concept['name'] }
    end

    def tags_and_values
      concepts.map { |concept| [concept['name'], concept['value']] }
    end
  end
end
