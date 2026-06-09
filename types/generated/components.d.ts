import type { Schema, Struct } from '@strapi/strapi';

export interface PolicyApplicableTier extends Struct.ComponentSchema {
  collectionName: 'components_policy_applicable_tiers';
  info: {
    displayName: 'Applicable Tier';
  };
  attributes: {
    tier: Schema.Attribute.Enumeration<
      ['Tier_1_High', 'Tier_2_Medium', 'Tier_3_Low']
    > &
      Schema.Attribute.Required;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'policy.applicable-tier': PolicyApplicableTier;
    }
  }
}
