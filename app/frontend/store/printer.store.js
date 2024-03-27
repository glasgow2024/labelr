export const SET_PRINTERS = "SET PRINTERS";
export const SELECT_PRINTER = "SELECT PRINTER";
export const SET_ENVIRONMENT = "SET ENVIRONMENT";

export const printerStore = {
  state: {
    printers: [],
    environment: null,
    selected_printer: null
  },
  mutations: {
    [SET_PRINTERS](state, printers) {
      state.printers = printers
    },
    [SELECT_PRINTER](state, selected_printer) {
      state.selected_printer = selected_printer
    },
    [SET_ENVIRONMENT](state, environment) {
      state.environment = environment
    }
  }
}
