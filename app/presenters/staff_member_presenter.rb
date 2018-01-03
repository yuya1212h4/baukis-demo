class StaffMemberPresenter < ModelPresenter
  # 職員の停止フラグのOn/Offを表現する記号を返す
  # on: BALLOT BOX WITH CHECK (U+2611)
  # off: BALLOT BOX (U+2610)
  def suspended_mark
    object.suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end
end
