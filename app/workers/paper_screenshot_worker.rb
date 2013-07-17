class PaperScreenshotWorker
  include Sidekiq::Worker
  def perform(paper_id)
    paper = Paper.find(paper_id)
    if paper
      kit = IMGKit.new(paper.web_view_url,width: paper.width, height: paper.height, quality: 100)
      image = kit.to_img(:jpg)
      
      image_file = Tempfile.new(["#{paper.id}", '.jpg'], 'tmp', encoding: 'ascii-8bit')
      image_file.write(image)
      image_file.flush
      
      paper.thumbnail = File.open(image_file, "rb")
      paper.save
      
      image_file.unlink
    end 
  end
end
