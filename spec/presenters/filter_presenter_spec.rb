RSpec.describe FilterPresenter do
  include GdsApi::TestHelpers::ContentDataApi
  let(:document_types) { default_document_types }
  let(:organisations) { default_organisations }
  let(:search_parameters) do
    {
      document_type: 'news_story',
      organisation_id: 'org-id'
    }
  end

  subject do
    FilterPresenter.new(
      search_parameters,
      document_types,
      organisations,
    )
  end

  describe '#document_type_options' do
    context 'when valid document type in parameter' do
      it 'formats the document types for the options component' do
        expect(subject.document_type_options).to eq([
          { text: 'All document types', value: '', selected: false },
          { text: 'Case study', value: 'case_study', selected: false },
          { text: 'Guide', value: 'guide', selected: false },
          { text: 'News story', value: 'news_story', selected: true },
          { text: 'HTML publication', value: 'html_publication', selected: false }
        ])
      end
    end

    context 'when no document type in parameter' do
      before { search_parameters[:document_type] = '' }
      it 'formats the document types for the options component' do
        expect(subject.document_type_options).to eq([
          { text: 'All document types', value: '', selected: true },
          { text: 'Case study', value: 'case_study', selected: false },
          { text: 'Guide', value: 'guide', selected: false },
          { text: 'News story', value: 'news_story', selected: false },
          { text: 'HTML publication', value: 'html_publication', selected: false }
        ])
      end
    end
  end

  describe '#organisation_options' do
    context 'when valid organisation id in parameter' do
      it 'formats the organisations for the options component' do
        expect(subject.organisation_options).to eq([
          { text: 'All organisations', value: 'all', selected: false },
          { text: 'No primary organisation', value: 'none', selected: false },
          { text: 'org (OI)', value: 'org-id', selected: true },
          { text: 'another org', value: 'another-org-id', selected: false },
          { text: 'Users Org (UOI)', value: 'users-org-id', selected: false }
        ])
      end
    end

    context 'when organisation_id is `all` in parameter' do
      before { search_parameters[:organisation_id] = 'all' }

      it 'formats the organisations for the options component' do
        expect(subject.organisation_options).to eq([
          { text: 'All organisations', value: 'all', selected: true },
          { text: 'No primary organisation', value: 'none', selected: false },
          { text: 'org (OI)', value: 'org-id', selected: false },
          { text: 'another org', value: 'another-org-id', selected: false },
          { text: 'Users Org (UOI)', value: 'users-org-id', selected: false }
        ])
      end
    end

    context 'when organisation_id is `none` in parameter' do
      before { search_parameters[:organisation_id] = 'none' }

      it 'formats the organisations for the options component' do
        expect(subject.organisation_options).to eq([
          { text: 'All organisations', value: 'all', selected: false },
          { text: 'No primary organisation', value: 'none', selected: true },
          { text: 'org (OI)', value: 'org-id', selected: false },
          { text: 'another org', value: 'another-org-id', selected: false },
          { text: 'Users Org (UOI)', value: 'users-org-id', selected: false }
        ])
      end
    end
  end

  describe '#document_type?' do
    context 'when valid document type in parameter' do
      it 'returns true' do
        expect(subject.document_type?).to eq(true)
      end
    end

    context 'when no document type in parameter' do
      before { search_parameters[:document_type] = '' }
      it 'returns false' do
        expect(subject.document_type?).to eq(false)
      end
    end
  end

  describe '#document_type' do
    it 'returns the formatted document type' do
      expect(subject.document_type).to eq("News story")
    end
  end

  describe '#organisation_name' do
    it 'returns the selected organisation name' do
      expect(subject.organisation_name).to eq('org (OI)')
    end
  end
end
