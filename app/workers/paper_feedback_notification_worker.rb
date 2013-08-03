class PaperFeedbackNotificationWorker
  include Sidekiq::Worker
  def perform(paper_id, feedback)
    paper = Paper.find(paper_id)
    if paper
      paper.participants.each { |u| 
        n = Notification.create({
          sender: nil,
          recipient: u,
          notification_type: "paper_feedback_sended",
          source_id: paper.id,
          picture: paper.thumbnail.url,
          text: "#{paper.recipient_name}님이 #{feedback}" ##{paper.title} 페이퍼에 대한 메시지를 보내셨습니다."
        })
        ap n
        n.send_apn
      }
    end
  end
end
