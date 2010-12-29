class Admin::CardsController < Admin::AdminController
  def cutting_sheet
    prawnto :prawn => { :margin => 0 }
  end
  def perforating_sheet
    prawnto :prawn => { :margin => 0 }
  end
end
