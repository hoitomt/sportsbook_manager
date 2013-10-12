helpers do
  def currency(amount)
    return '$0.00' if amount.blank?
    sprintf("$%.2f", amount)
  end
end
