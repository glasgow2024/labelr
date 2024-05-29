import { NEW } from './model.store';

export const NEW_IMPRESSION = 'NEW IMPRESSION';

export const impressionModel = 'impression';

export const impressionEndpoints = {
  [impressionModel]: 'impression'
}

export const impressionStore = {
  actions: {
    [NEW_IMPRESSION]({ dispatch }, { user_id, registable_id, registable_type, label_used, user_name, label_type }) {
      let newImpression = {
        user_id: user_id,
        registable_id: registable_id,
        registable_type: registable_type,
        label_used: label_used,
        user_name: user_name,
        label_type: label_type
      }

      return dispatch(NEW, { model: impressionModel, selected: false, ...newImpression });
    },
  },
  selected: {
    [impressionModel]: undefined
  }
}
