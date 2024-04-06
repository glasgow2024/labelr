import { NEW } from './model.store';

export const NEW_USER = 'NEW USER';

export const userModel = 'user';

export const userEndpoints = {
  [userModel]: 'user'
}

export const userStore = {
  actions: {
    [NEW_USER]({ dispatch }, { name, email, role }) {
      let newUser = {
        name: name,
        email: email,
        role: role
      }

      return dispatch(NEW, { model: userModel, selected: false, ...newUser });
    },
  },
  selected: {
    [userModel]: undefined
  }
}
