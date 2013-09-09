module TimeSlotsHelper
  def dj_tokens(time_slot)
    # [{id: dj.id, name: dj.dj_name}]
    time_slot.djs.map { |dj| {id: dj.id, dj_name: dj.dj_name} }.to_json
  end
end
