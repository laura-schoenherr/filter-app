class AddReminderMailSettings < ActiveRecord::Migration[5.2]
  def change
  end

  def data
    site_name = Setting.get('site_name')
    Setting.create!(
      key: 'reminder_mail_14_days_subject',
      value: "#{site_name} hat seit {{wochen}} nichts mehr von Ihnen gehört."
    )
    Setting.create!(
      key: 'reminder_mail_14_days_body',
      value: t = <<~DOC
        <p>
          Sie erhalten diese E-Mail, da Sie am {{anmeldedatum}} den #{site_name} Newsletter abonniert haben. Bedauerlicherweise konnte ich seit dem {{letzte-oeffnung}} keine Nutzung des Newsletters feststellen. Bei länger anhaltender Inaktivität steht eine automatische Löschung Ihres Newsletter-Abonnements bevor.
        </p>
        <p>
          Mit Klick auf diesem Button senden Sie ein Aktivitätssignal. Der Automatische Löschvorgang wird daraufhin ausgesetzt:
        </p>
        <table class='button'><tr><td><a href="{{link}}">{{link}}</a></td></tr></table>

        <p>Sollten Sie weiterhin kein Interesse am #{site_name}-Newsletter haben, dann können Sie ihn hier abbestellen:</p>
        <a href="{{abbestellen-link}}">Abbestellen</a>

        #{site_name} verwendet Ihre Kontaktdaten ausschließlich zum Versand des #{site_name} Newsletters. Sofern ich weiterhin keine Nutzung des Newsletters feststellen kann, wird Ihr Abonnenment automatisch am {{loeschdatum}} gelöscht.
      DOC
    )

    Setting.create!(
      key: 'reminder_mail_3_days_subject',
      value: "#{site_name} - Bevorstehende Löschung Ihres Newsletter-Abos in drei Tagen"
    )
    Setting.create!(
      key: 'reminder_mail_3_days_body',
      value: t,
    )

    Setting.create!(
      key: 'reminder_mail_1_days_subject',
      value: "Dringend! Automatische Löschung Ihres #{site_name}-Abos steht kurz bevor!"
    )
    Setting.create!(
      key: 'reminder_mail_1_days_body',
      value: t,
    )

    Setting.create!(
      key: 'reminder_unsubscribe_notice_subject',
      value: "Hinweis: Ihr #{site_name} Newsletter-Abonnenment wurde soeben gelöscht."
    )
    Setting.create!(
      key: 'reminder_unsubscribe_notice_body',
      value: <<~DOC
        <p>Sie erhalten diese E-Mail, da Sie am {{anmeldedatum}} den #{site_name} Newsletter abonniert haben. Bedauerlicherweise konnte ich seit dem {{letzte-oeffnung}} keine Nutzung des Newsletters feststellen. Aufgrund ihrer Inaktivität wurde Ihr Abonnement automatisch gelöscht. Schade!</p>
        <p>Falls Sie es sich anders überlegen, können sie hier erneut ein frisches Abonnement abschließen:</p>
        <table class='button'><tr><td><a href="{{subscribe-link}}">Neuen Newsletter anmelden</a></td></tr></table>
      DOC
    )
  end
end
