require 'gcm'
require 'json'
require 'digest/sha1'

module ApplicationHelper
  def sendGcmMsg(reg_ids, data)
    to_be_packet = {}
    to_be_packet["data"] = data
    to_be_packet["delay_while_idle"] = true
    # to_be_packet["dry_run"] = true
    logger.warn to_be_packet
    gcm = GCM.new("AIzaSyDL_zErXcHvWb4xzuJiACMdY9xEaV8PUYw")
    response = gcm.send(reg_ids, to_be_packet)
  end

  def generateToken(original)
    Digest::SHA1.hexdigest(original)
  end
end
