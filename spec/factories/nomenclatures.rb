FactoryGirl.define do
  factory :parent_nomenclature, class: Nomenclature do
    title 'Отдел валютных операций'
  end
  factory :child_nomenclature, class: Nomenclature do
    title 'Начальник'
  end
  factory :nomenclature_invalid, class: Nomenclature do
    title 'Имя'
  end
  factory :nomenclature_null, class: Nomenclature do
    title ''
  end
end
