require 'spec_helper'

describe Spree::Gateway::PayPalExpress do
  let!(:gateway) do
    described_class.new.tap do |g|
      g.set_preference :login, 'test'
      g.set_preference :password, 'test'
      g.set_preference :signature, 'test'
    end
  end

  describe '#supports?' do
    let(:source) { nil }
    subject { gateway.supports? source }

    context 'when the given source is a Spree::PaypalExpressCheckout' do
      let!(:source) { Spree::PaypalExpressCheckout.new }
      it { is_expected.to be_truthy }
    end

    context 'when the given source is not a Spree::PaypalExpressCheckout' do
      let!(:source) { Spree::CreditCard.new }
      it { is_expected.to be_falsey }
    end
  end

  describe '#method_type' do
    subject { gateway.method_type }
    it { is_expected.to eq 'paypal_express' }
  end

  describe '#purchase_link' do
    let!(:order) { create :order_with_totals }
    let(:options) { {} }
    subject { -> { gateway.purchase_link order, options } }

    context 'when no return_url and cancel_return_url are given' do
      it { is_expected.to raise_error(ArgumentError) }
    end

    context 'when the return_url and cancel_return_url are given' do
      let(:options) { { return_url: 'http://test.com', cancel_return_url: 'http://test.com' } }

      before do
        expected_options = options.merge({
          max_amount: order.total.to_f,
          allow_guest_checkout: true
        })
        expect(gateway.provider).to \
          receive(:setup_purchase)
          .with(order.total.to_f, expected_options)
          .and_return(double(params: { 'token' => 'TEST-TOKEN' }))
      end

      it { expect(subject.call).to eq 'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=TEST-TOKEN' }
    end
  end

  describe '#purchase' do
    let(:total) { 100.0 }
    let(:source) { Spree::PaypalExpressCheckout.new(token: 'TEST-TOKEN', payer_id: 'payer-id') }
    let(:options) { {} }
    subject { -> { gateway.purchase total, source, options } }

    context 'when no options are passed in' do
      let(:options) { {} }

      before do
        expected_options = { token: 'TEST-TOKEN', payer_id: 'payer-id' }
        expect(gateway.provider).to receive(:purchase).with(total, expected_options)
      end

      it { is_expected.to_not raise_error }
    end
  end
end
