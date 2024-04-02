import { NEW } from './model.store';

export const NEW_IMPRESSION = 'NEW IMPRESSION';

export const impressionModel = 'impression';

export const impressionEndpoints = {
  [impressionModel]: 'impression'
}

export const impressionStore = {
  actions: {
    [NEW_IMPRESSION]({ dispatch }, { user_id, registrant_id, label_used, user_name }) {
      let newImpression = {
        user_id: user_id,
        registrant_id: registrant_id,
        label_used: label_used,
        user_name: user_name
      }

      return dispatch(NEW, { model: impressionModel, selected: false, ...newImpression });
    },
  },
  selected: {
    [impressionModel]: undefined
  }
}
