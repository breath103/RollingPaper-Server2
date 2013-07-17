class PaperDeadlineNotificationWorker
  include Sidekiq::Worker
  def perform(paper_id)
    paper = Paper.find(paper_id)
    if paper
      # 방 참여자 모두에게 데드라인 메시지를 보냄
      paper.participants.each { |u| 
        Notification.create({
          sender: nil,
          recipient: u,
          notification_type: "paper_deadline",
          source_id: paper.id,
          picture: paper.background,
          text: "10분뒤 #{paper.title} 페이퍼 제작이 끝나요. 얼른 롤링페이퍼를 완성해보세요."
        }).send_apn
      }
    end
  end
end
