
export const registrantModel = 'registrant';

export const registrantEndpoints = {
  [registrantModel]: 'registration/registrant'
}

// TODO - we need a relationship from registrant to printed info
export const registrantStore = {
  selected: {
    [registrantModel]: undefined
  }
}
