require 'rails_helper'

module SolidusLiquid
  RSpec.describe Theme, type: :model do
    describe 'active_theme' do
      xit 'should not allow destroying of active theme' do
        theme = create(:theme)
        create(:active_theme, theme: theme)

        theme.destroy

        expect(theme.errors.full_messages).to eq(
          ['Cannot delete record because a dependent active theme exists']
        )
      end
    end

    xdescribe '#role' do
      it 'should have "main" role if active theme' do
        theme = create(:theme)

        expect(theme.role).to eq('main')
      end

      it 'should have "unpublished" role if inactive theme' do
        theme = create(:theme)

        expect(theme.role).to eq('unpublished')
      end
    end

    describe '#settings' do
      it 'queries redis cache' do
        theme = create(:theme)
        redis = double('redis', get: '{}')
        allow(Redis).to receive(:current) { redis }

        theme.settings

        expect(redis)
          .to have_received(:get).with("solidus_liquid_themes_#{theme.id}")
      end
    end

    describe '#previewable' do
      it 'always returns true' do
        expect(Theme.new.previewable).to be true
      end
    end

    describe '#processing' do
      it 'always returns false' do
        expect(Theme.new.processing).to be false
      end
    end
  end
end
