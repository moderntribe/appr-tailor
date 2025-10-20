'use strict';

const CONTENT_CONTAINERS = {
  GLOSSARY_PAGE: {
    type: 'GLOSSARY_PAGE',
    label: 'Glossary Content',
    types: ['GLOSSARY_ITEM'],
    required: true
  },
  RESOURCE_PAGE: {
    templateId: 'CEPP_CONTAINER',
    type: 'RESOURCE_PAGE',
    label: 'Resource Content',
    displayHeading: true,
    required: true,
    config: { types: ['RESOURCE_BLOCK'] }
  },
  CONTENT_PAGE: {
    templateId: 'CEPP_CONTAINER',
    type: 'CEPP_CONTAINER',
    label: 'Content',
    displayHeading: true,
    required: true,
    config: { types: ['CONTENT_BLOCK', 'TASK_BLOCK'] }
  },
  INTRO: {
    templateId: 'CEPP_CONTAINER',
    type: 'INTRO',
    label: 'Introduction',
    required: false,
    displayHeading: true,
    multiple: false,
    config: {
      types: ['CONTENT_BLOCK', 'TASK_BLOCK'],
      allowDelete: true,
      bottomDivider: true
    }
  },
  DELIVERABLE_PAGE: {
    templateId: 'CEPP_CONTAINER',
    type: 'CEPP_DELIVERABLE_CONTAINER',
    label: 'Deliverable/Activity Content',
    displayHeading: true,
    required: true,
    config: { types: ['DELIVERABLE', 'CONTENT_BLOCK', 'TASK_BLOCK'] }
  }
};

const CONTENT = {
  type: 'CONTENT_PAGE',
  label: 'Content Page',
  hasAssessments: false,
  hasExams: false,
  meta: [
    getNameMeta('Content page title'),
    getTimeMeta('Content page'),
    getRolesMeta()
  ],
  contentContainers: [CONTENT_CONTAINERS.CONTENT_PAGE.type],
  color: '#b265ff'
};

const MEETING_PREP = {
  type: 'MEETING_PREP',
  label: 'Meeting Preparation',
  hasAssessments: false,
  hasExams: false,
  meta: [
    getNameMeta('Meeting preparation title'),
    getTimeMeta('Meeting preparation'),
    getRolesMeta()
  ],
  contentContainers: [
    CONTENT_CONTAINERS.INTRO.type,
    CONTENT_CONTAINERS.CONTENT_PAGE.type
  ],
  color: '#f08d81'
};

const MEETING = {
  type: 'MEETING',
  label: 'Meeting',
  hasAssessments: false,
  hasExams: false,
  meta: [
    getNameMeta('Meeting name'),
    getTimeMeta('Meeting'),
    getRolesMeta()
  ],
  relationships: [{
    type: 'meetingPrep',
    label: 'Meeting Prep',
    placeholder: 'Select meeting prep',
    multiple: false,
    allowEmpty: false,
    allowedTypes: ['MEETING_PREP']
  }],
  contentContainers: [
    CONTENT_CONTAINERS.INTRO.type,
    CONTENT_CONTAINERS.CONTENT_PAGE.type
  ],
  color: '#ea6a66'
};

const DELIVERABLE = {
  type: 'DELIVERABLE',
  label: 'Deliverable/Activity',
  hasAssessments: false,
  hasExams: false,
  meta: [
    getNameMeta('Deliverable/Activity name'),
    getTimeMeta('Deliverable/Activity'),
    getRolesMeta()
  ],
  contentContainers: [CONTENT_CONTAINERS.DELIVERABLE_PAGE.type],
  color: '#60c6ce'
};

const SECTION = {
  type: 'SECTION',
  label: 'Section',
  rootLevel: true,
  hasAssessments: false,
  hasExams: false,
  subLevels: [
    CONTENT.type,
    MEETING_PREP.type,
    MEETING.type,
    DELIVERABLE.type
  ],
  meta: [
    getNameMeta('Section name'),
    {
      key: 'sectionGroup',
      type: 'INPUT',
      label: 'Section group label',
      placeholder: 'Enter section group label',
      validate: { max: 150 }
    }
  ],
  color: '#2f5b7b'
};

const GLOSSARY = {
  type: 'GLOSSARY',
  label: 'Glossary Page',
  rootLevel: true,
  hasAssessments: false,
  hasExams: false,
  contentContainers: [
    CONTENT_CONTAINERS.GLOSSARY_PAGE.type
  ],
  color: '#765f8a'
};

const RESOURCE = {
  type: 'RESOURCE',
  label: 'Resource Page',
  rootLevel: true,
  hasAssessments: false,
  hasExams: false,
  contentContainers: [CONTENT_CONTAINERS.RESOURCE_PAGE.type],
  color: '#854239'
};

const CEPP_PROJECT_SCHEMA = {
  id: 'CEPP_PROJECT',
  name: 'CEPP Project',
  structure: [
    GLOSSARY,
    RESOURCE,
    SECTION,
    CONTENT,
    MEETING_PREP,
    MEETING,
    DELIVERABLE
  ],
  contentContainers: [
    CONTENT_CONTAINERS.GLOSSARY_PAGE,
    CONTENT_CONTAINERS.RESOURCE_PAGE,
    CONTENT_CONTAINERS.CONTENT_PAGE,
    CONTENT_CONTAINERS.INTRO,
    CONTENT_CONTAINERS.DELIVERABLE_PAGE
  ],
  elementMeta: [{
    type: 'IMAGE',
    inputs: getImageMeta()
  }, {
    type: 'PDF',
    inputs: getPDFMeta()
  }, {
    type: 'VIDEO',
    inputs: getVideoMeta()
  }, {
    type: 'AUDIO',
    inputs: getAudioMeta()
  }, {
    type: 'JODIT_HTML',
    inputs: getJoditHtmlMeta(),
    relationships: [{
      type: 'link',
      key: 'link',
      label: 'Element link (###LINK:title###)',
      multiple: false,
      allowedTypes: []
    }]
  }, {
    type: 'ACCORDION',
    inputs: getAccordionMeta()
  }, {
    type: 'VIDEO_PLAYLIST',
    inputs: getVideoPlaylistMeta()
  }, {
    type: 'BREAK',
    inputs: getBreakMeta()
  }]
};

module.exports = {
  SCHEMAS: [CEPP_PROJECT_SCHEMA],
  WORKFLOWS: []
};

function getNameMeta(label = '') {
  return {
    key: 'name',
    type: 'INPUT',
    label,
    placeholder: `Enter ${label.toLowerCase()}...`,
    validate: { required: true, max: 150 }
  };
}

function getTimeMeta(label = '', required = false) {
  return {
    key: 'time',
    type: 'INPUT',
    label: `${label} time`,
    placeholder: `Enter ${label.toLowerCase()} time in minutes...`,
    validate: { required, numeric: true }
  };
}

function getRolesMeta() {
  const roles = [
    { value: 'TA', label: 'TA Provider (Learning)' },
    { value: 'TEAM_LEAD', label: 'Team Lead (Learning)' },
    { value: 'TEAM_MEMBER', label: 'Team Member (Learning)' },
    { value: 'CHAMPION', label: 'Project Champion (Learning)' },
    { value: 'TRAINING_PARTICIPANT', label: 'Training Participant (Training)' },
    { value: 'FACULTY', label: 'Faculty (Training)' },
    { value: 'FACULTY_LEAD', label: 'Faculty Lead (Training)' },
    { value: 'PRODUCTION_MANAGER', label: 'Production Manager (Training)' }
  ];

  return {
    key: 'roles',
    type: 'MULTISELECT',
    label: 'Select roles or leave empty to allow all',
    options: roles
  };
}

function getJoditHtmlMeta() {
  const style = {
    key: 'style',
    type: 'CEPP_HTML_STYLE'
  };

  const removeTopPadding = {
    key: 'removeTopPadding',
    type: 'SWITCH',
    label: 'Remove element top padding'
  };

  const removeBottomPadding = {
    key: 'removeBottomPadding',
    type: 'SWITCH',
    label: 'Remove element bottom padding'
  };

  return [
    style,
    removeTopPadding,
    removeBottomPadding
  ];
}

function getAccordionMeta() {
  const styles = {
    key: 'accordionStyle',
    type: 'SELECT',
    label: 'Select accordion style',
    options: [{
      label: 'knowledge check',
      value: 'knowledgeCheck'
    }, {
      label: 'optional content',
      value: 'optionalContent'
    }]
  };

  const colors = {
    key: 'color',
    type: 'SELECT',
    label: 'Select Accordion color',
    options: [{
      label: 'dark blue',
      value: '#343F79'
    }, {
      label: 'light blue',
      value: '#F7F9FB'
    }]
  };

  const customColor = {
    key: 'customColor',
    type: 'COLOR',
    label: 'Pick a custom color'
  };

  return [
    styles,
    colors,
    customColor
  ];
}

function getAudioMeta() {
  return [{
    key: 'transcriptFile',
    type: 'FILE',
    label: 'Transcript',
    placeholder: 'Click to upload transcript file'
  }];
}

function getVideoMeta() {
  const type = {
    key: 'type',
    type: 'SELECT',
    label: 'Select video type',
    options: [{
      label: 'regular (full-size)',
      value: 'regular'
    }, {
      label: 'expandable (not applicable in playlist)',
      value: 'expandable'
    }]
  };

  const title = {
    key: 'title',
    type: 'INPUT',
    label: 'Title',
    placeholder: 'Enter video title'
  };

  const description = {
    key: 'description',
    type: 'TEXTAREA',
    label: 'Description',
    placeholder: 'Click to add description...'
  };

  const transcript = {
    key: 'transcriptFile',
    type: 'FILE',
    label: 'Transcript',
    placeholder: 'Click to upload transcript file'
  };

  const caption = {
    key: 'caption',
    type: 'FILE',
    label: 'Caption',
    placeholder: 'Click to upload text file',
    validate: { ext: ['vtt'] }
  };

  const thumbnail = {
    key: 'thumbnail',
    type: 'FILE',
    label: 'Thumbnail',
    placeholder: 'Click to upload thumbnail',
    validate: { ext: ['jpg', 'jpeg', 'png'] }
  };

  const backgroundColor = {
    key: 'backgroundColor',
    type: 'COLOR',
    label: 'Pick a background color'
  };

  const borderColor = {
    key: 'borderColor',
    type: 'COLOR',
    label: 'Pick a border color'
  };

  return [
    type,
    title,
    description,
    transcript,
    caption,
    thumbnail,
    backgroundColor,
    borderColor
  ];
}

function getImageMeta() {
  const caption = {
    key: 'caption',
    type: 'INPUT',
    label: 'Caption',
    placeholder: 'Enter image caption'
  };

  const altText = {
    key: 'altText',
    type: 'INPUT',
    label: 'Alt text',
    placeholder: 'Enter image alt text'
  };

  return [caption, altText];
}

function getVideoPlaylistMeta() {
  const title = {
    key: 'title',
    type: 'INPUT',
    label: 'Title',
    placeholder: 'Enter Playlist title'
  };

  const description = {
    key: 'description',
    type: 'INPUT',
    label: 'Description',
    placeholder: 'Enter Playlist Description'
  };

  const backgroundColor = {
    key: 'backgroundColor',
    type: 'COLOR',
    label: 'Pick a background color'
  };

  const borderColor = {
    key: 'borderColor',
    type: 'COLOR',
    label: 'Pick a border color'
  };

  return [
    title,
    description,
    backgroundColor,
    borderColor
  ];
}

function getBreakMeta() {
  return [{
    key: 'height',
    type: 'INPUT',
    label: 'Height(px)',
    placeholder: 'Enter Break height in pixels'
  }];
}

function getPDFMeta() {
  return [{
    key: 'title',
    type: 'INPUT',
    label: 'Title',
    placeholder: 'Enter PDF title'
  }];
}
