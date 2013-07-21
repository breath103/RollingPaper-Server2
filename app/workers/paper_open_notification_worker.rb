class PaperOpenNotificationWorker
  include Sidekiq::Worker
  def perform(paper_id)
    paper = Paper.find(paper_id)
    if paper
      # 방 참여자 모두에게 데드라인 메시지를 보냄
      paper.participants.each { |u| 
        n = Notification.create({
          sender: nil,
          recipient: u,
          notification_type: "paper_opened",
          source_id: paper.id,
          picture: paper.thumbnail.url,
          text: "#{paper.recipient_name}님이 #{paper.title}페이퍼를 열어보았습니다."
        })
        ap n
        n.send_apn
      }
    end
  end
end
