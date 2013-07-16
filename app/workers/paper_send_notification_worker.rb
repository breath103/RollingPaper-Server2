class PaperSendNotificationWorker
  include Sidekiq::Worker
  def perform(paper_id)
    paper = Paper.find(paper_id)
    
    if paper && paper.state == "editing"
      # 1. 방 상태를 전송으로 바꾼다
      ap paper
      paper.state = "sended"
      paper.save

      # 2. 방을 판사람에게 방을 전송하라고 알린다
      paper_sender = paper.creator
      paper_sender.send_notification(Notification.create({
        sender: nil,
        recipient: paper_sender,
        notification_type: "paper_needs_to_be_sended",
        source_id: paper.id,
        picture: paper.background,
        text: "#{paper.title}를 다 만들었습니다. #{paper.recipient_name}님의 담벼락에 올려주세요."
      }))

      # 3. 방을 받을사람이 혹시 앱을 사용하는 사람이라면 푸쉬를 보낸다
      recipient = User.find_by_facebook_id( paper.friend_facebook_id )
      if recipient 
        recipient.send_notification(Notification.create({
          sender: nil,
          recipient: recipient,
          notification_type: "paper_received",
          source_id: paper.id,
          picture: paper.background,
          text: "#{paper.title} 페이퍼가 도착하였습니다."
        }))
      end
    end

  end
end
