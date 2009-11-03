package Moosp::Eval;

use Moose;

=head1 NAME

Moosp::Eval - Evaluator

=cut

has 'stack_point' => (is => 'rw', isa => 'Int', default => 0);
has 'stack' => (is => 'rw', 
		isa => 'ArrayRef[Moosp::Sexp]', 
		default => sub{[]},
	       );

=head2 sexpEval

=cut

sub sexpEval {
  my ($self, $lambda, $body, $form) = @_;
  my $old_stack_point = $self->stack_point;
  my ($ret, $arg, $swap, $sym);

  while(1){
    $arg = $form->car;
    $ret = $self->eval($arg);
    $self->stack->[$self->stack_point] = $ret;
    $self->stack_point($self->stack_point+1);
    last if ($form->cdr->isa('Moosp:Nil'));
    $form = $form->cdr;
  }

  my $arg_list = $lambda;
  my $sp = $old_stack_point;

  while(1) {
    $sym = $arg_list->car;
    $swap = $sym->value;
    $sym->value($self->stack->[$sp]);
    $self->stack->[$sp++] = $swap;
    last if ($arg_list->cdr->isa('Moosp::Nil'));
    $arg_list = $arg_list->cdr;
  }

  $ret = $self->evalBody($body);

  $arg_list = $lambda;
  $self->stack_point($old_stack_point);

  while(1){
    $sym = $arg_list->car;
    $sym->value($self->stack->[$old_stack_point++]);
    last if ($arg_list->cdr->isa('Moosp::Nil'));
    $arg_list = $arg_list->cdr;
  }

  return $ret;
}

=head2 eval

=cut

sub eval {
  my ($self, $form) = @_;

  if ($form->isa('Moosp::Symbol')) {
    my $symbol_value = $form->value;
    unless ($symbol_value) {
      warn "Error: " . $form->serialize . " is unbound.";
      return Moosp::Nil->instance;
    }
    return $symbol_value;
  }

  return $form if ($form->isa('Moosp::Atom'));

  my $car = $form->car;

  if ($car->isa('Moosp::Symbol')) {

    my $fun = $car->value;

    unless ($fun) {
      warn "Error: " . $car->serialize . " is not defined.";
      return Moosp::Nil->instance;
    }

    if ($fun->isa('Moosp::Function')) {
      my $argument_list = $form->cdr;
      return $fun->fun($argument_list);
    }

    if ($fun->isa('Moosp::List')) {
      my $cdr = $fun->cdr;
      my $lambda_list = $cdr->car;
      my $body = $cdr->cdr;
      return $self->evalBody($body) if ($lambda_list->isa('Moosp::Nil'));
      return $self->sexpEval($lambda_list, $body, $form->cdr);
    }
    return $form;
  }

#  return $form->car if $form->isa('Moosp::List');
  return $form;
}

=head2 evalBody

=cut

sub evalBody {
  my ($self, $body) = @_;
  my $ret;
  while(1){
    $ret = $self->eval($body->car);
    last if ($body->cdr->isa('Moosp::Nil'));
    $body = $body->cdr;
  }
  return $ret;
}

1; # End of Moosp::Eval
